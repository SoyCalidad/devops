🚀 GitHub Action para Despliegue Automático de Odoo via SSH
<div align="center"> <img src="https://www.odoo.com/web/image/res.company/1/logo?unique=f3db218" alt="Odoo Logo" width="200"> <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Actions Logo" width="200"> <h3>Despliegue continuo de módulos Odoo con GitHub Actions</h3> </div>

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

## 2. 🔐 Configurar SSH Private Key (IMPORTANTE)

1. Generar Claves SSH
    ssh-keygen -t rsa -b 4096 -C "github-actions-odoo" -f ~/.ssh/github-actions-odoo -N ""

2. Configurar Servidor
    cat ~/.ssh/github-actions-odoo.pub >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys

3. Configurar GitHub
    cat ~/.ssh/github-actions-odoo
    Settings → Secrets → New repository secret

## 🛠️ Cómo Usar

Copiar el workflow:
    mkdir -p .github/workflows
    wget -O .github/workflows/deploy.yml https://ejemplo.com/deploy.ymlo
Configurar todas las variables
Hacer push a la rama principal:

Configura todas las variables de entorno

Realiza un push a la rama principal y ¡listo!

## ⚙️ Flujo de Trabajo
Actualizar Código: Hace pull del código más reciente

Buscar Módulos: Detecta automáticamente módulos Odoo

Actualizar Bases: Aplica updates a todas las BDs

Reiniciar Odoo: Finaliza con reinicio del contenedor

## 📌 Notas Importantes
Requiere Docker en el servidor destino

El usuario SSH necesita permisos para ejecutar comandos docker

Recomendado usar un usuario dedicado para despliegues

Las actualizaciones se realizan sin downtime gracias al reinicio controlado

## 🆘 Soporte
¿Problemas con el despliegue? Abre un issue en este repositorio con:

El error completo

Tu configuración (ocultando datos sensibles)

Versión de Odoo