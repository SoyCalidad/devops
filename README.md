🚀 GitHub Action para Despliegue Automático de Odoo via SSH
<div align="center"> <img src="https://www.odoo.com/web/image/res.company/1/logo?unique=f3db218" alt="Odoo Logo" width="200"> <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Actions Logo" width="200"> <h3>Despliegue continuo de módulos Odoo con GitHub Actions</h3> </div>

🔧 Configuración Requerida
## 1. 🛠️ Variables de Configuración

| Variable               | Descripción                                  | Ejemplo                | Tipo       |
|------------------------|----------------------------------------------|------------------------|------------|
| 🌐 `SERVER_IP`         | Dirección del servidor destino               | `odoo.midominio.com`   | Required   |
| 👤 `SSH_USER`          | Usuario para conexión SSH                    | `odoo_deploy`          | Required   |
| 🐳 `DOCKER_ODOO`       | Nombre contenedor Odoo                       | `odoo17-prod`          | Required   |
| 🗃️ `DOCKER_DB`        | Nombre contenedor PostgreSQL                 | `pg-odoo17`            | Required   |
| 📂 `RUTA_ODOO`        | Ruta base de instalación                     | `/opt/odoo/17.0`       | Required   |
| 🌿 `RAMA_PRINCIPAL`   | Rama monitoreada para despliegues            | `main`                 | Required   |
| 🔑 `SSH_PRIVATE_KEY`   | Clave SSH (agregar como Secret)              | [Ver instrucciones]    | Secret     |

2. 🔐 Configurar SSH Private Key (IMPORTANTE)
Genera una clave SSH en tu servidor si no tienes una:

bash
ssh-keygen -t rsa -b 4096 -C "github-actions-deploy"
Agrega la clave pública al archivo authorized_keys del usuario:

bash
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
Obtén la clave privada:

bash
cat ~/.ssh/id_rsa
Agrega como secret en GitHub:

Ve a Settings → Secrets and variables → Actions

Haz clic en "New repository secret"

Nombre: SSH_PRIVATE_KEY

Valor: El contenido completo de tu clave privada (incluyendo -----BEGIN RSA PRIVATE KEY----- y -----END RSA PRIVATE KEY-----)

🛠️ Cómo Usar
Copia el archivo .github/workflows/deploy.yml a tu repositorio

Configura todas las variables de entorno

Realiza un push a la rama principal y ¡listo!

⚙️ Flujo de Trabajo
Actualizar Código: Hace pull del código más reciente

Buscar Módulos: Detecta automáticamente módulos Odoo

Actualizar Bases: Aplica updates a todas las BDs

Reiniciar Odoo: Finaliza con reinicio del contenedor

📌 Notas Importantes
Requiere Docker en el servidor destino

El usuario SSH necesita permisos para ejecutar comandos docker

Recomendado usar un usuario dedicado para despliegues

Las actualizaciones se realizan sin downtime gracias al reinicio controlado

🆘 Soporte
¿Problemas con el despliegue? Abre un issue en este repositorio con:

El error completo

Tu configuración (ocultando datos sensibles)

Versión de Odoo