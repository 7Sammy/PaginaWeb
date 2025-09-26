const SUPABASE_URL = 'https://zqowhanlhhjueqprxrvt.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpxb3doYW5saGhqdWVxcHJ4cnZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgyNTQ3MDQsImV4cCI6MjA3MzgzMDcwNH0.gqUUKlZXow6UpVrEWd77XPbZO4p0IiDdZ5Cq3QMY178';

const supabase = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

// ================== ELEMENTOS DEL DOM ==================
const btnLogin = document.getElementById('btn-login');
const loginPopup = document.getElementById('login-popup');
const loginForm = document.querySelector('.login-form');
const subirBtn = document.getElementById('subir-doc');
const galeria = document.querySelector('.galeria');
const body = document.body;

// ================== ADMIN ==================
const ADMIN_EMAIL = "geison.c.samaniego@gmail.com";
const ADMIN_PASSWORD = "123456789";

// ================== POPUP LOGIN ==================
btnLogin.addEventListener('click', () => {
    loginPopup.classList.add('visible');
    body.style.filter = 'brightness(0.4)';
});

loginPopup.addEventListener('click', (e) => {
    if(e.target === loginPopup){
        loginPopup.classList.remove('visible');
        body.style.filter = 'brightness(1)';
    }
});

// ================== LOGIN ==================
loginForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const email = loginForm.querySelector('input[type="email"]').value;
    const password = loginForm.querySelector('input[type="password"]').value;

    if(email === ADMIN_EMAIL && password === ADMIN_PASSWORD){
        alert("Has iniciado sesión como admin");
        subirBtn.style.display = 'block';
    } else {
        alert("Has iniciado sesión como usuario visitante");
        subirBtn.style.display = 'none';
    }

    loginPopup.classList.remove('visible');
    body.style.filter = 'brightness(1)';

    cargarDocumentos();
});

// ================== SUBIR DOCUMENTOS ==================
subirBtn.addEventListener('click', async () => {
    // Elegir semana
    const semana = prompt("Ingresa la semana (1 a 16) donde quieres subir el documento:");
    if(!semana || semana < 1 || semana > 16){
        alert("Semana inválida");
        return;
    }

    const input = document.createElement('input');
    input.type = 'file';
    input.accept = '.pdf';
    input.multiple = true;
    input.click();

    input.addEventListener('change', async () => {
        const files = input.files;
        for(let i=0; i<files.length; i++){
            const file = files[i];
            const nombreArchivo = `Semana${semana}_${file.name}`;
            const { data, error } = await supabase.storage
                .from('documentos')
                .upload(nombreArchivo, file, { upsert: true });

            if(error){
                console.error(error);
                alert(`Error al subir: ${file.name}`);
            }
        }
        cargarDocumentos();
    });
});

// ================== CARGAR DOCUMENTOS ==================
async function cargarDocumentos(){
    const { data, error } = await supabase.storage
        .from('documentos')
        .list('', { limit: 100 });

    if(error){
        console.error(error);
        return;
    }

    galeria.innerHTML = '';

    // Organizar por semana
    const semanas = {};
    data.forEach(doc => {
        const match = doc.name.match(/^Semana(\d+)_/);
        const numSemana = match ? parseInt(match[1]) : 0;
        if(!semanas[numSemana]) semanas[numSemana] = [];
        semanas[numSemana].push(doc);
    });

    for(let i=1; i<=16; i++){
        const docs = semanas[i] || [];
        const divSemana = document.createElement('div');
        divSemana.classList.add('proyecto');
        divSemana.innerHTML = `<div class="overlay"><h3>Semana ${i}</h3></div>`;
        docs.forEach(doc => {
            const url = supabase.storage.from('documentos').getPublicUrl(doc.name).data.publicUrl;
            const a = document.createElement('a');
            a.href = url;
            a.target = "_blank";
            a.textContent = doc.name.replace(`Semana${i}_`, '');
            divSemana.appendChild(a);
            divSemana.appendChild(document.createElement('br'));
        });
        galeria.appendChild(divSemana);
    }
}

// ================== CARGAR DOCUMENTOS AL INICIO ==================
cargarDocumentos();
