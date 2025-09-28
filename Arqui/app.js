// app.js — versión con Supabase Auth (correo+contraseña)
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const supabaseUrl = 'https://evrymhfnvaketvhoezil.supabase.co'
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV2cnltaGZudmFrZXR2aG9lemlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg5OTk5NTcsImV4cCI6MjA3NDU3NTk1N30.5ibcTjFSO0x02GLXzB_9zPrqoLoqV-XLuRnSQJc-WbQ'
export const supabase = createClient(supabaseUrl, supabaseKey)

// ---- refs UI
const loginBtn      = document.getElementById('login-btn')
const logoutBtn     = document.getElementById('logout-btn') // añade este botón en tu HTML (puede estar oculto)
const loginModal    = document.getElementById('login-modal')
const closeModal    = document.getElementById('close-modal')
const loginForm     = document.getElementById('login-form')
const uploadSection = document.getElementById('upload-section')
const uploadForm    = document.getElementById('upload-form')
const uploadInput   = document.getElementById('upload-input')
const selectSemana  = document.getElementById('select-semana')
const weekScroll    = document.getElementById('week-scroll')
const weekContent   = document.getElementById('week-content')
const allWeeksBtn   = document.getElementById('all-weeks-btn')

// estado
let isAdmin = false

// ---- helpers UI
function show(elem){ if(elem) elem.style.display = '' }
function hide(elem){ if(elem) elem.style.display = 'none' }

// ---- modal (si tienes modal.js, puedes quitar estos listeners)
loginBtn?.addEventListener('click', () => loginModal.classList.add('show'))
closeModal?.addEventListener('click', () => loginModal.classList.remove('show'))
window.addEventListener('click', e => { if (e.target === loginModal) loginModal.classList.remove('show') })
window.addEventListener('keydown', e => { if (e.key === 'Escape') loginModal.classList.remove('show') })

// ---- Auth: iniciar sesión con correo+contraseña (usuario real de Supabase)
loginForm?.addEventListener('submit', async (e) => {
  e.preventDefault()
  const email = document.getElementById('admin-email').value.trim()
  const password = document.getElementById('admin-pass').value

  const { data, error } = await supabase.auth.signInWithPassword({ email, password })
  if (error) {
    alert('Acceso denegado: ' + (error.message || 'revisa tu correo/contraseña'))
    return
  }
  // ok
  loginModal.classList.remove('show')
})

// ---- cerrar sesión
logoutBtn?.addEventListener('click', async () => {
  await supabase.auth.signOut()
})

// ---- reaccionar a cambios de sesión
supabase.auth.onAuthStateChange(async (_event, session) => {
  isAdmin = !!session
  if (isAdmin) {
    show(uploadSection)
    show(logoutBtn)
    hide(loginBtn)
  } else {
    hide(uploadSection)
    hide(logoutBtn)
    show(loginBtn)
  }
  renderDocuments()
})

// ---- generar botones Semana 1..16
for (let i = 1; i <= 16; i++) {
  const btn = document.createElement('button')
  btn.classList.add('week-btn')
  btn.textContent = `Semana ${i}`
  btn.dataset.semana = i
  btn.addEventListener('click', () => renderDocuments(i))
  weekScroll.appendChild(btn)

  const option = document.createElement('option')
  option.value = i
  option.textContent = `Semana ${i}`
  selectSemana.appendChild(option)
}

allWeeksBtn?.addEventListener('click', () => renderDocuments())

// ---- listar documentos
async function renderDocuments(semana = null) {
  weekContent.innerHTML = '<p>Cargando documentos...</p>'

  let query = supabase.from('documentos').select('*').order('semana', { ascending: true })
  if (semana) query = query.eq('semana', semana)

  const { data, error } = await query
  if (error) { weekContent.innerHTML = '<p>Error al cargar documentos.</p>'; console.error(error); return }
  if (!data || data.length === 0) { weekContent.innerHTML = '<p>No hay documentos.</p>'; return }

  weekContent.innerHTML = ''
  const grouped = {}
  data.forEach(doc => (grouped[doc.semana] ??= []).push(doc))

  Object.keys(grouped).forEach(s => {
    const section = document.createElement('div')
    section.classList.add('semana-section')
    section.innerHTML = `<h3>Semana ${s}</h3>`

    grouped[s].forEach(doc => {
      const div = document.createElement('div')
      div.classList.add('doc-item')
      div.innerHTML = `
        <p><strong>${doc.nombre}</strong></p>
        <a href="${doc.url}" target="_blank" class="btn">Ver</a>
        <a href="${doc.url}" download class="btn">Descargar</a>
      `
      if (isAdmin) {
        const delBtn = document.createElement('button')
        delBtn.textContent = 'Eliminar'
        delBtn.classList.add('btn', 'btn-danger')
        delBtn.onclick = async () => {
          const { error: delError } = await supabase.from('documentos').delete().eq('id', doc.id)
          if (delError) { alert('Error al eliminar'); console.error(delError) }
          else renderDocuments(semana)
        }
        div.appendChild(delBtn)
      }
      section.appendChild(div)
    })
    weekContent.appendChild(section)
  })
}

// ---- subir archivo + registrar DB (solo admin autenticado)
uploadForm?.addEventListener('submit', async e => {
  e.preventDefault()
  if (!isAdmin) { alert('Primero inicia sesión'); return }

  const file = uploadInput.files[0]
  const semana = selectSemana.value
  if (!file || !semana) { alert('Selecciona archivo y semana'); return }

  const filePath = `${Date.now()}_${file.name}`
  const { error: uploadError } = await supabase.storage.from('documentos').upload(filePath, file)
  if (uploadError) { alert('Error al subir archivo'); console.error(uploadError); return }

  const url = supabase.storage.from('documentos').getPublicUrl(filePath).data.publicUrl
  const { error: dbError } = await supabase.from('documentos').insert([{ nombre: file.name, semana: parseInt(semana), url }])
  if (dbError) { alert('Error al guardar en DB'); console.error(dbError); return }

  alert('Documento subido correctamente')
  uploadInput.value = ''
  renderDocuments()
})

// ---- cargar al inicio (y forzar lectura de sesión)
;(async () => {
  const { data: { session } } = await supabase.auth.getSession()
  isAdmin = !!session
  if (isAdmin) { show(uploadSection); show(logoutBtn); hide(loginBtn) } else { hide(uploadSection); hide(logoutBtn); show(loginBtn) }
  renderDocuments()
})()
