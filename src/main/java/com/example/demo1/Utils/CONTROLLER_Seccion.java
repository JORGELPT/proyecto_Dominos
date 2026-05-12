package com.example.demo1.Utils;

/**
 * Singleton que mantiene la sesión del usuario logueado.
 *
 * El campo {@code rol} almacena el valor exacto de
 * {@code tbl_usuario.rol} (normalizado a minúsculas).
 * Los roles válidos según el CHECK constraint CK_tbl_usuario_rol son:
 *
 *   administrador  → acceso total al sistema
 *   gerente        → todo excepto administración de usuarios
 *   cajero         → Inicio, Inventario (solo ver), Ventas, Cliente
 *   cliente        → Inicio, Registrar Pedido, Reclamación
 *
 * Nota sobre "delivery": El Maincontroller hace referencia al rol
 * {@code delivery}, pero este valor no está permitido por el CHECK
 * de la BD. El método esDelivery() se conserva por compatibilidad
 * y siempre devolverá false mientras el rol no se agregue al CHECK.
 */
public class CONTROLLER_Seccion {

    // -----------------------------------------------------------------------
    //  Singleton
    // -----------------------------------------------------------------------
    private static CONTROLLER_Seccion instancia;

    private CONTROLLER_Seccion() {}

    public static CONTROLLER_Seccion getInstancia() {
        if (instancia == null) {
            instancia = new CONTROLLER_Seccion();
        }
        return instancia;
    }

    // -----------------------------------------------------------------------
    //  Datos de sesión
    // -----------------------------------------------------------------------
    private int     idPersona  = -1;
    private int     idEmpleado = -1;
    private int     idCliente  = -1;
    private String  nombre     = "";
    private String  rol        = ""; // valor de tbl_usuario.rol en minúsculas
    private String  email      = "";
    private boolean activa     = false;

    // -----------------------------------------------------------------------
    //  Iniciar / Cerrar sesión
    // -----------------------------------------------------------------------
    public void iniciar(int idPersona, int idEmpleado, int idCliente,
                        String nombre, String rol, String email) {
        this.idPersona  = idPersona;
        this.idEmpleado = idEmpleado;
        this.idCliente  = idCliente;
        this.nombre     = nombre != null ? nombre : "";
        this.rol        = rol    != null ? rol.trim().toLowerCase() : "cliente";
        this.email      = email  != null ? email  : "";
        this.activa     = true;
    }

    public void cerrar() {
        idPersona  = -1;
        idEmpleado = -1;
        idCliente  = -1;
        nombre     = "";
        rol        = "";
        email      = "";
        activa     = false;
    }

    // -----------------------------------------------------------------------
    //  Getters
    // -----------------------------------------------------------------------
    public int     getIdPersona()  { return idPersona; }
    public int     getIdEmpleado() { return idEmpleado; }
    public int     getIdCliente()  { return idCliente; }
    public String  getNombre()     { return nombre; }
    public String  getRol()        { return rol; }
    public String  getEmail()      { return email; }
    public boolean isActiva()      { return activa; }

    // -----------------------------------------------------------------------
    //  Comprobaciones de rol
    //  NOTA: "admin" y "administrador" se consideran equivalentes para que
    //        el Maincontroller siga funcionando aunque en la BD el valor
    //        oficial sea "administrador".
    // -----------------------------------------------------------------------

    /** Rol administrador → acceso total. Acepta "admin" o "administrador". */
    public boolean esAdmin() {
        return "administrador".equalsIgnoreCase(rol)
                || "admin".equalsIgnoreCase(rol);
    }

    /** Rol gerente → todo excepto administración de usuarios. */
    public boolean esGerente() {
        return "gerente".equalsIgnoreCase(rol);
    }

    /** Rol cajero → Inicio, Inventario (solo ver), Ventas, Cliente. */
    public boolean esCajero() {
        return "cajero".equalsIgnoreCase(rol);
    }

    /**
     * Rol delivery → Inicio y gestión de envíos.
     * Este rol NO existe en el CHECK constraint de tbl_usuario,
     * por lo que este método siempre devolverá false a menos que se
     * agregue 'delivery' al CK_tbl_usuario_rol.
     */
    public boolean esDelivery() {
        return "delivery".equalsIgnoreCase(rol);
    }

    /** Rol cliente → Inicio, Registrar Pedido, Reclamación. */
    public boolean esCliente() {
        return "cliente".equalsIgnoreCase(rol);
    }

    public boolean esAdminOGerente() {
        return esAdmin() || esGerente();
    }

    // -----------------------------------------------------------------------
    //  Permisos semánticos por funcionalidad
    // -----------------------------------------------------------------------
    public boolean puedeCrearReclamacion() {
        return esAdmin() || esGerente() || esCajero() || esCliente();
    }

    public boolean puedeHacerPedido() {
        return esAdmin() || esGerente() || esCajero() || esCliente();
    }

    public boolean puedeGestionarEnvio() {
        return esAdmin() || esGerente() || esCajero() || esDelivery();
    }

    public boolean puedeVerInventario() {
        return esAdmin() || esGerente() || esCajero() || esDelivery();
    }

    public boolean puedeModificarInventario() {
        return esAdmin() || esGerente();
    }

    // -----------------------------------------------------------------------
    //  Permisos genéricos de CRUD (usados por Permisos_Util)
    // -----------------------------------------------------------------------
    public boolean puedeInsertar() {
        return esAdmin() || esGerente() || esCajero() || esCliente();
    }

    public boolean puedeEditar() {
        return esAdmin() || esGerente();
    }

    public boolean puedeEliminar() {
        return esAdmin() || esGerente();
    }

    public boolean puedeBuscar() {
        return activa;
    }

    public boolean puedeCrearUsuarios() {
        return esAdmin();
    }

    @Override
    public String toString() {
        return "Sesion{idPersona=" + idPersona
                + ", nombre='" + nombre + '\''
                + ", rol='"    + rol    + '\''
                + ", activa="  + activa + '}';
    }
}
