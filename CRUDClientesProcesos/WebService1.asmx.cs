using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace CRUDClientesProcesos
{
    /// <summary>
    /// Descripción breve de WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string Crear_Producto_WS(string cod_p, string nom_pro, string marca_pro,
                    string descri_pro, float prec_com, float prec_venta, string mat_pro)
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Nuevo_Producto(conn.GetConexion(), cod_p, nom_pro, marca_pro, descri_pro, prec_com, prec_venta, mat_pro);
        }

        [WebMethod]
        public string Actualizar_Producto_WS(int id, string cod_p, string nom_pro, string marca_pro,
                    string descri_pro, float prec_com, float prec_venta, string mat_pro)
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Actualizar_Producto(conn.GetConexion(), id, cod_p, nom_pro, marca_pro, descri_pro, prec_com, prec_venta, mat_pro);
        }

        [WebMethod]
        public string Eliminar_Producto_WS(int id)
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Eliminar_Producto(conn.GetConexion(), id);
        }
        [WebMethod]
        public string Ver_Productos_WS()
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Ver_Productos(conn.GetConexion());
        }

        [WebMethod]
        public string Crear_ADMIN_WS(string nom, string ape, string fec_nac,
                                string carg, string uss, string pass)
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Nuevo_Admin(conn.GetConexion(), nom, ape, fec_nac, carg, uss, pass);
        }

        [WebMethod]
        public string Actualizar_ADMIN_DP_WS(int id_ad, string nom, string ape, string fec_nac,
                                string carg)
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Actualizar_Admin_DP(conn.GetConexion(), id_ad, nom, ape, fec_nac, carg);
        }

        [WebMethod]
        public string Actualizar_ADMIN_US_WS(int id_ad, string uss, string pass)
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Actualizar_Admin_user(conn.GetConexion(), id_ad, uss, pass);
        }

        [WebMethod]
        public string Eliminar_ADMIN_WS(int id)
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Eliminar_ADMIN(conn.GetConexion(), id);
        }

        [WebMethod]
        public string Ver_ADMIN_WS()
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Ver_Admins(conn.GetConexion());
        }

        [WebMethod]
        public string LG_ADMIN_WS(string usuario, string contrasena)
        {
            Conexion conn = new Conexion();
            conn.EstablecerConnection();
            Procedimientos pc = new Procedimientos();
            return pc.Admin_Login(conn.GetConexion(), usuario, contrasena);
        }
    }
}
