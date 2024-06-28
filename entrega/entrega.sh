#!/bin/bash

# Pilar de Barros 323823


# Función para validar el formato de email
validar_email() {
    local email=$1
    if [[ $email =~ .*@.* ]]; then
        return 0
    else
        return 1
    fi
}

# Función para verificar si la cédula ya existe en el archivo
cedula_existe() {
    local cedula=$1
    if grep -q "^$cedula," socios.txt; then
        return 0
    else
        return 1
    fi
}


# Función para volver al menú principal
volver_menu() {
    echo "=================================================="
    echo ""
    read -p "¿DESEA VOLVER AL MENU PRINCIPAL? (SI/NO): " respuesta
    echo ""
    echo "=================================================="

    case $respuesta in 
        SI)
            mostrar_menu
            ;;
        NO)
            return 0
            ;;
        *)
            echo "Seleccione una opcion valida: "
            volver_menu
            clear
    esac    
}


mostrar_menu() {
    clear  # Limpiar la consola
    echo ""
    echo "============================== MENU PRINCIPAL =============================="
    echo "|                                                                          |"
    echo "| 1 - REGISTRAR SOCIOS                                                     |"
    echo "| 2 - LISTAR SOCIOS                                                        |"
    echo "| 3 - PRODUCTOS DE LA VETERINARIA                                          |"
    echo "| 4 - SALIR                                                                |"
    echo "|                                                                          |"
    echo "============================================================================"
    echo ""
}



# Función para registrar un nuevo socio
registrar_socios() {

    echo "======================================================================================="
    echo "|                                                                                     |"
    echo "|                                REGISTRO DE SOCIO                                    |"
    echo "|                                                                                     |"
    echo "======================================================================================="
    echo "|                                                                                     |"
    echo "|  Para ser socio de nuestra veterinaria, por favor ingrese los datos a continuación  |"
    echo "|                                                                                     |"
    echo "======================================================================================="

    echo "Ingrese nombre del dueño:"
    read nombre_dueno
    if [[ -z $nombre_dueno ]]; then
        echo "Error: El nombre del dueño no puede estar vacío."
	echo ""
        return
    fi

    echo "Ingrese cédula del dueño:"
    read cedula
    if [[ -z $cedula ]]; then
        echo "Error: La cédula no puede estar vacía."
        echo ""
	return

    fi

    if cedula_existe "$cedula"; then
        echo "Error: La cédula ingresada ya existe en el sistema."
	echo ""
	return

    fi

    echo "Ingrese nombre de la mascota:"
    read nombre_mascota
    if [[ -z $nombre_mascota ]]; then
        echo "Error: El nombre de la mascota no puede estar vacío."
	echo ""
	return

    fi

    echo "Ingrese edad de la mascota:"
    read edad_mascota

    echo "Ingrese email de contacto:"
    read email
    if ! validar_email "$email"; then
        echo "Error: El formato del email no es válido."
	echo ""
	return

    fi

    # Guardar en el archivo socios.txt
    echo "$nombre_dueno,$cedula,$nombre_mascota,$edad_mascota,$email" >> socios.txt
    echo ""
    echo "USTED HA SIDO REGISTRADO COMO SOCIO."
    echo ""

}

#Función para la opción 2

listar_socios() {
    echo ""
    echo "=================================================="
    echo "               SOCIOS REGISTRADOS                 "
    echo "=================================================="
    echo ""
    cut -d':' -f1 "socios.txt"
    echo ""
    echo ""
}

#Función para la opción 3

listar_productos() {

    echo "======================================================================================="
    echo "|                                                                                     |"
    echo "|                            PRODUCTOS DE LA VETERINARIA                              |"
    echo "|                                                                                     |"
    echo "======================================================================================="
    echo "|                                                                                     |"
    echo "| 1. Alimento para mascotas                                                           |"
    echo "| 2. Medicamentos veterinarios                                                        |"
    echo "| 3. Accesorios para mascotas                                                         |"
    echo "| 4. Servicios de peluquería y baño                                                   |"
    echo "| 5. Paseos al aire libre                                                             |"
    echo "| 6. Enretenimiento para mascotas                                                     |"
    echo "| 7. Otros servicios veterinarios                                                     |"
    echo "|                                                                                     |"
    echo "======================================================================================="

}


# Función para cerrar sesion
cerrar_sesion(){
    echo ""
    echo "=================================================="
    echo ""
    echo "                CERRANDO SESIÓN...                "
    echo ""
    echo "                 ¡HASTA LUEGO!                    "
    echo ""
    echo "=================================================="
    clear
    exit 0
}


# Función de error
error(){
    echo "=================================================="
    echo ""
    echo "             ERROR: OPCION NO VALIDA              "
    echo ""
    echo "                INTENTE NUEVAMENTE                "
    echo ""
    echo "=================================================="
}


# Loop menú

while true; do
        mostrar_menu
        read -p "SELECCIONE UNA OPCION DEL MENU: " opcion
        echo ""
        case $opcion in 
            1)  clear
                registrar_socios
                volver_menu registrar_socios
                ;;
            2)  clear
                listar_socios
                volver_menu listar_socios
                ;;
            3)  clear
                listar_productos
                volver_menu listar_productos
                ;;
            4)  clear
                cerrar_sesion
                ;;
	esac
done
