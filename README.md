# AWS Website Deploy

Desplegaremos un sitio web en AWS utilizando el script terraform de este repositorio

# Requisitos Previos:

1. Tener instalado AWS CLI, con los permisos de usuario configurados previamente, esto es las claves de accceso en **aws configure**

2. Proporcionar las **Políticas de permisos** al usuario creado en el servicio  **IAM**, esto es que goce de los permisos para acceder a **EC2**

![image](https://github.com/jonma0107/aws-terraform-site/assets/53632260/672627a9-3891-4e31-acaa-e7e899467894)

3. Instalar Terraform

## Introducción Breve a Terraform:

Terraform es una herramienta de infraestructura como código (IaC) creada por HashiCorp que permite definir y gestionar la infraestructura de manera declarativa. Permite describir la infraestructura deseada en archivos de configuración, luego Terraform se encarga de planificar y aplicar esos cambios de manera eficiente.

**Analogía:**

Imagina que estás construyendo una casa. En lugar de construir cada habitación y cableado manualmente, utilizas un plano arquitectónico. Terraform sería como ese plano para tu infraestructura de TI. Defines cómo debe ser tu infraestructura en un archivo (el plano), y Terraform se encarga de construir y gestionar todo según ese plano. Si necesitas hacer cambios, simplemente actualizas el plano y Terraform se asegura de que la infraestructura real se ajuste a esa visión. Es como tener un arquitecto para tu infraestructura digital.

# Instalación Paso a Paso de Terraform en Linux Ubuntu

A continuación, se presentan los pasos detallados para instalar Terraform en Linux Ubuntu:

## 1. Actualizar el Sistema:

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

## 2. Importar la Clave GPG de HashiCorp:

Asegúrate de la autenticidad del software añadiendo la clave GPG de HashiCorp a las claves confiables.

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/hashicorp.gpg --import
```

## 3. Modificar Permisos:

Asegura que la clave sea reconocida correctamente por el sistema.

```bash
sudo chmod 644 /etc/apt/trusted.gpg.d/hashicorp.gpg
```

## 4. Agregar el Repositorio de HashiCorp:

Integra el repositorio de HashiCorp para que tu sistema sepa exactamente dónde obtener Terraform.

```bash
echo "deb [signed-by=/etc/apt/trusted.gpg.d/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

## 5. Instalar Terraform:

Con todo configurado, es hora de instalar Terraform.

```bash
sudo apt update && sudo apt install terraform
```

[Fuente](https://medium.com/techyon-dev/a-quick-guide-to-install-terraform-on-ubuntu-23-04-8e76e467c59a)

# Crear un Par de Claves en AWS EC2

Para crear un par de claves (key pair) en AWS EC2, sigue estos pasos:

1. **Inicia sesión en la Consola de AWS:**
   - Accede a la [Consola de AWS](https://aws.amazon.com/console/).

2. **Navega a EC2:**
   - En la consola, selecciona el servicio **EC2**.

3. **Dirígete a "Key Pairs":**
   - En el panel de navegación izquierdo, busca y selecciona "Key Pairs" bajo la sección "Network & Security".

4. **Crea un Nuevo Par de Claves:**
   - Haz clic en el botón "Create Key Pair".

5. **Ingresa un Nombre para la Clave:**
   - Asigna un nombre descriptivo a tu clave en el campo "Key pair name".

6. **Elige el Formato del Archivo de Clave:**
   - Puedes seleccionar el formato del archivo de clave privada (por lo general, PEM o PPK). AWS te proporcionará la clave pública para descargar.

7. **Haz clic en "Create Key Pair":**
   - Una vez ingresados los detalles, haz clic en el botón "Create Key Pair".

8. **Guarda la Clave Privada:**
   - Después de hacer clic, se descargará automáticamente un archivo con la clave privada en tu computadora. ¡Asegúrate de guardarla en un lugar seguro!

**Nota Importante:**
   - La clave privada es crucial para acceder a las instancias EC2. Guarda la clave de manera segura y no la compartas con personas no autorizadas.

Con estos pasos, has creado con éxito un nuevo par de claves para usar con tus instancias EC2 en AWS.

Como vamos a lanzar una instancia de EC2 en AWS por medio de los scripts de Terraform, es indispensable crear una "Key Pair" para la configuración previa de nuestro script de tarraform.

# Creación de Archivos Terraform para VPC y Proveedor AWS

Para la creación de los archivos `vpc.tf` y `providers.tf` en Terraform, nos basamos en la documentación oficial proporcionada por HashiCorp para el proveedor AWS. A continuación, se detallan los enlaces a las secciones específicas de la documentación que hemos consultado:

## Creación de `vpc.tf`:
- Consultamos la documentación de recursos VPC de AWS en el enlace: [AWS VPC - Terraform Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc).
- El archivo `vpc.tf` contiene la configuración necesaria para definir y crear una Virtual Private Cloud (VPC) en AWS.

## Creación de `providers.tf`:
- Referenciamos la documentación general del proveedor AWS para Terraform en: [AWS Provider - Terraform Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest).
- El archivo `providers.tf` incluye la configuración del proveedor AWS, estableciendo las credenciales y la región para interactuar con los recursos de AWS.

Al seguir estas referencias de documentación, hemos estructurado y configurado nuestros archivos Terraform de manera consistente con las mejores prácticas y las directrices proporcionadas por HashiCorp y AWS.
 
# Ejecución de Comandos Terraform

Una vez que has configurado tus scripts con la información de EC2 y la región de AWS, puedes seguir estos pasos para ejecutar los comandos básicos de Terraform:

## 1. Inicializar el Proyecto:

Ejecuta el siguiente comando para inicializar tu proyecto Terraform:

```bash
terraform init
```

![image](https://github.com/jonma0107/aws-terraform-site/assets/53632260/f5ba42ca-20a2-40d2-bde8-5b8e17aedb1c)

Este comando descargará los proveedores y configuraciones necesarios para tu proyecto.

## 2. Validar la Configuración:

Asegúrate de que tu configuración Terraform sea válida mediante el siguiente comando:

```bash
terraform validate
```

![image](https://github.com/jonma0107/aws-terraform-site/assets/53632260/e02e0bc4-6032-4397-a7b1-2aa839881176)

Este comando verifica la sintaxis y estructura de tus archivos Terraform.

## 3. Planificar los Cambios:

Antes de aplicar los cambios, utiliza el siguiente comando para planificar y revisar los cambios propuestos:

```bash
terraform plan
```

![image](https://github.com/jonma0107/aws-terraform-site/assets/53632260/f497b9ec-ab66-4390-a65f-7d9728e54be5)

Esto mostrará un resumen de las acciones que Terraform tomará.

## 4. Aplicar los Cambios:

Una vez que estés satisfecho con el plan, ejecuta el siguiente comando para aplicar los cambios y crear los recursos en AWS:

![image](https://github.com/jonma0107/aws-terraform-site/assets/53632260/dfb8fc22-cb0e-4959-919b-4be544aedd00)

Serás solicitado a confirmar la acción. Ingresa "yes" para proceder.

![image](https://github.com/jonma0107/aws-terraform-site/assets/53632260/2d5b7ab8-9026-456d-97dc-eda6c754258c)

¡Listo! Has ejecutado con éxito los comandos básicos de Terraform para inicializar, validar, planificar y aplicar cambios en tu infraestructura en AWS.

Nos dirigimos a nuestras instancias y verificamos que la instancia que se configuró en el archivo èc2.tf` se haya creado, accedemos a ella y nos desplazamos hasta identificar la dirección IP pública. Más adelante un dominio puede apuntar a esta dirección IP.

![image](https://github.com/jonma0107/aws-terraform-deploy/assets/53632260/ad590597-810a-4835-a428-7aa6e20d45e9)

También nos podemos dar cuenta que se han creado el VPC (Virtual private cloud), en este caso la vpc personalizada llamada **custom-vpc** que se configuró en el archivo `vpc.tf`, así mismo la Subnet (public subnet Az1), la tabla de rutas (public route table) y el Internet Gateway (int-gw). También se implemntó **Security Groups** (web-sg) configurado en el archivo `security-group.tf`


