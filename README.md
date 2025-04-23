GitHub Action para Despliegue Automático de Odoo via SSH
![Odoo Logo](https://www.odoo.com/web/image/res.company/1/logo?unique=f3db218)
![GitHub Actions Logo](https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png)
Plantilla para desplegar automáticamente módulos de Odoo en un servidor remoto cuando se hace push a la rama principal.

🔧 Configuración Requerida
1. Variables de Entorno
Configura estas variables en tu repositorio (Settings → Secrets and variables → Actions):

Variable	Descripción	Ejemplo
SERVER_IP	IP o dominio del servidor	192.168.1.100
SSH_USER	Usuario SSH con permisos	odoo_user
DOCKER_ODOO	Nombre contenedor Odoo	odoo17
DOCKER_DB	Nombre contenedor PostgreSQL	odoo-db-17
REPO_NAME	Nombre de tu repositorio	custom-addons
RAMA_PRINCIPAL	Rama a desplegar	17.0
PUERTO_ACTUALIZACION	Puerto para updates	8069
RUTA_ODOO	Ruta base de Odoo	/home/odoo_user/Odoo/17.0
RUTA_MODULOS	Ruta a módulos	addons
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