// ========== CONFIGURAR SUPABASE ==========
const SUPABASE_URL = 'https://zqowhanlhhjueqprxrvt.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpxb3doYW5saGhqdWVxcHJ4cnZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgyNTQ3MDQsImV4cCI6MjA3MzgzMDcwNH0.gqUUKlZXow6UpVrEWd77XPbZO4p0IiDdZ5Cq3QMY178';

const supabase = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

// ========== DOM ==========
const btnLogin = document.getElementById('btn-login');
const loginPopup = document.getElementById('login-popup');
const loginForm = document.querySelector('.login-form');
const subirBtn = document.getElementById('subir-doc');
const galeria = document.querySelector('.galeria');
const body = document.body;

// ========== CREDENCIALES ADMIN ==========
const ADMIN_EMAIL = "geison.c.samaniego@gmail.com";
const ADMIN_PASSWORD = "123456789";

// ========== LOGIN POPUP ==========
btnLogin.addEventListener('click', () => {
  loginPopup.classList.add('visible');
  body.style.filter = 'brightness(0.4)';
});

loginPopup.addEventListener('click', (e) => {
  if (e.target === loginPopup) {
    loginPopup.classList.remove('visible');
    body.style.filter = 'brightness(1)';
  }
});

// ========== VALIDAR LOGIN ==========
loginForm.addEventListener('submit', (e) => {
  e.preventDefault();

  const email = loginForm.querySelector('input[type="email"]').value;
  const password = loginForm.querySelector('input[type="password"]').value;

  const isAdmin = (email === ADMIN_EMAIL && password === ADMIN_PASSWORD);

  if (isAdmin) {
    alert("✅ Bienvenido, admin.");
    subirBtn.style.display = 'block';
  } else {
    alert("👀 Has iniciado como visitante.");
    subirBtn.style.display = 'none';
  }

  loginPopup.classList.remove('visible');
  body.style.filter = 'brightness(1)';
  cargarDocumentos();
});

// ========== SUBIR DOCUMENTOS ==========
subirBtn.addEventListener('click', () => {
  const semana = prompt("¿A qué semana deseas subir el archivo? (1-16)");
  if (!semana || semana < 1 || semana > 16) {
    alert("Semana inválida.");
    return;
  }

  const input = document.createElement('input');
  input.type = 'file';
  input.accept = '.pdf';
  input.multiple = true;
  input.click();

  input.addEventListener('change', async () => {
    const files = input.files;
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const nombre = `Semana${semana}_${file.name}`;

      const { error } = await supabase.storage
        .from('documentos')
        .upload(nombre, file, { upsert: true });

      if (error) {
        console.error(error);
        alert(`❌ Error al subir: ${file.name}`);
      }
    }

    cargarDocumentos();
  });
});

// ========== CARGAR DOCUMENTOS ==========
async function cargarDocumentos() {
  const { data, error } = await supabase.storage
    .from('documentos')
    .list('', { limit: 100 });

  if (error) {
    console.error("Error al cargar documentos:", error);
    return;
  }

  galeria.innerHTML = '';

  const semanas = {};
  data.forEach(doc => {
    const match = doc.name.match(/^Semana(\d+)_/);
    const semana = match ? parseInt(match[1]) : 0;
    if (!semanas[semana]) semanas[semana] = [];
    semanas[semana].push(doc);
  });

  for (let i = 1; i <= 16; i++) {
    const divSemana = document.createElement('div');
    divSemana.classList.add('proyecto');

    const overlay = document.createElement('div');
    overlay.classList.add('overlay');
    const titulo = document.createElement('h3');
    titulo.textContent = `Semana ${i}`;
    overlay.appendChild(titulo);
    divSemana.appendChild(overlay);

    const docs = semanas[i] || [];
    docs.forEach(doc => {
      const url = supabase.storage.from('documentos').getPublicUrl(doc.name).data.publicUrl;
      const link = document.createElement('a');
      link.href = url;
      link.textContent = doc.name.replace(`Semana${i}_`, '');
      link.target = "_blank";
      divSemana.appendChild(link);
      divSemana.appendChild(document.createElement('br'));
    });

    galeria.appendChild(divSemana);
  }
}

// ========== INICIAL ==========
window.addEventListener('DOMContentLoaded', () => {
  subirBtn.style.display = 'none'; // Ocultar subir al inicio
  cargarDocumentos();
});
