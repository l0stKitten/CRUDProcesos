using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text.Json.Serialization;
using System.Web;

namespace CRUDClientesProcesos
{
    public class Procedimientos
    {
        public string Nuevo_Producto(OracleConnection conn, string cod_p, string nom_pro, string marca_pro,
string descri_pro, float prec_com, float prec_venta , string mat_pro)
        {
            OracleParameter param_cod = new OracleParameter();
            param_cod.OracleDbType = OracleDbType.Varchar2;
            param_cod.Value = cod_p;

            OracleParameter param_nombre = new OracleParameter();
            param_nombre.OracleDbType = OracleDbType.Varchar2;
            param_nombre.Value = nom_pro;

            OracleParameter param_marca = new OracleParameter();
            param_marca.OracleDbType = OracleDbType.Varchar2;
            param_marca.Value = marca_pro;

            OracleParameter param_desc = new OracleParameter();
            param_desc.OracleDbType = OracleDbType.Varchar2;
            param_desc.Value = descri_pro;

            OracleParameter param_precc = new OracleParameter();
            param_precc.OracleDbType = OracleDbType.Varchar2;
            param_precc.Value = prec_com;

            OracleParameter param_precv = new OracleParameter();
            param_precv.OracleDbType = OracleDbType.Varchar2;
            param_precv.Value = prec_venta;

            OracleParameter param_mat = new OracleParameter();
            param_mat.OracleDbType = OracleDbType.Varchar2;
            param_mat.Value = mat_pro;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "create_producto";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("cod_p", OracleDbType.Varchar2).Value = param_cod.Value;
            cmd.Parameters.Add("nom_pro", OracleDbType.Varchar2).Value = param_nombre.Value;
            cmd.Parameters.Add("marca_pro", OracleDbType.Varchar2).Value = param_marca.Value;
            cmd.Parameters.Add("descri_pro", OracleDbType.Varchar2).Value = param_desc.Value;
            cmd.Parameters.Add("prec_com", OracleDbType.BinaryFloat).Value = param_precc.Value;
            cmd.Parameters.Add("prec_venta", OracleDbType.BinaryFloat).Value = param_precv.Value;
            cmd.Parameters.Add("mat_pro", OracleDbType.Varchar2).Value = param_mat.Value;

            cmd.ExecuteNonQuery();
            string respuesta = "Producto creado";
            conn.Dispose();
            return respuesta;
        }
        public string Eliminar_Producto(OracleConnection conn, int id)
        {
            OracleParameter param_id = new OracleParameter();
            param_id.OracleDbType = OracleDbType.Varchar2;
            param_id.Value = id;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "delete_producto";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("id_pr", OracleDbType.Int16).Value = param_id.Value;
            cmd.ExecuteNonQuery();

            string respuesta = "Producto eliminado";
            conn.Dispose();
            return respuesta;
        }
        public string Actualizar_Producto(OracleConnection conn, int id_prod, string cod_p, string nom_pro, string marca_pro,
string descri_pro, float prec_com, float prec_venta, string mat_pro)
        {
            OracleParameter param_id = new OracleParameter();
            param_id.OracleDbType = OracleDbType.Varchar2;
            param_id.Value = id_prod;

            OracleParameter param_cod = new OracleParameter();
            param_cod.OracleDbType = OracleDbType.Varchar2;
            param_cod.Value = cod_p;

            OracleParameter param_nombre = new OracleParameter();
            param_nombre.OracleDbType = OracleDbType.Varchar2;
            param_nombre.Value = nom_pro;

            OracleParameter param_marca = new OracleParameter();
            param_marca.OracleDbType = OracleDbType.Varchar2;
            param_marca.Value = marca_pro;

            OracleParameter param_desc = new OracleParameter();
            param_desc.OracleDbType = OracleDbType.Varchar2;
            param_desc.Value = descri_pro;

            OracleParameter param_precc = new OracleParameter();
            param_precc.OracleDbType = OracleDbType.Varchar2;
            param_precc.Value = prec_com;

            OracleParameter param_precv = new OracleParameter();
            param_precv.OracleDbType = OracleDbType.Varchar2;
            param_precv.Value = prec_venta;

            OracleParameter param_mat = new OracleParameter();
            param_mat.OracleDbType = OracleDbType.Varchar2;
            param_mat.Value = mat_pro;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "update_producto";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("id_pr", OracleDbType.Int16).Value = param_id.Value;
            cmd.Parameters.Add("cod_p", OracleDbType.Varchar2).Value = param_cod.Value;
            cmd.Parameters.Add("nom_pro", OracleDbType.Varchar2).Value = param_nombre.Value;
            cmd.Parameters.Add("marca_pro", OracleDbType.Varchar2).Value = param_marca.Value;
            cmd.Parameters.Add("descri_pro", OracleDbType.Varchar2).Value = param_desc.Value;
            cmd.Parameters.Add("prec_com", OracleDbType.BinaryFloat).Value = param_precc.Value;
            cmd.Parameters.Add("prec_venta", OracleDbType.BinaryFloat).Value = param_precv.Value;
            cmd.Parameters.Add("mat_pro", OracleDbType.Varchar2).Value = param_mat.Value;

            cmd.ExecuteNonQuery();
            string respuesta = "Producto actualizado";
            conn.Dispose();
            return respuesta;
        }

        public string Ver_Productos(OracleConnection conn)
        {
            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;

            cmd.CommandText = "read_productos";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("cur_prod", OracleDbType.RefCursor).Direction = ParameterDirection.Output;


            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);

            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }

        public string Nuevo_Admin(OracleConnection conn, string nom, string ape, string fec_nac,
                                string carg, string uss, string pass)
        {
            OracleParameter param_nom = new OracleParameter();
            param_nom.OracleDbType = OracleDbType.Varchar2;
            param_nom.Value = nom;

            OracleParameter param_apellido = new OracleParameter();
            param_apellido.OracleDbType = OracleDbType.Varchar2;
            param_apellido.Value = ape;

            OracleParameter param_fec_nac = new OracleParameter();
            param_fec_nac.OracleDbType = OracleDbType.Varchar2;
            param_fec_nac.Value = fec_nac;

            OracleParameter param_cargo = new OracleParameter();
            param_cargo.OracleDbType = OracleDbType.Varchar2;
            param_cargo.Value = carg;

            OracleParameter param_usuario = new OracleParameter();
            param_usuario.OracleDbType = OracleDbType.Varchar2;
            param_usuario.Value = uss;

            OracleParameter param_cont = new OracleParameter();
            param_cont.OracleDbType = OracleDbType.Varchar2;
            param_cont.Value = pass;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "admin_create";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("nom_ad", OracleDbType.Varchar2).Value = param_nom.Value;
            cmd.Parameters.Add("app_ad", OracleDbType.Varchar2).Value = param_apellido.Value;
            cmd.Parameters.Add("fec_nac", OracleDbType.Varchar2).Value = param_fec_nac.Value;
            cmd.Parameters.Add("cargo", OracleDbType.Varchar2).Value = param_cargo.Value;
            cmd.Parameters.Add("usuario", OracleDbType.Varchar2).Value = param_usuario.Value;
            cmd.Parameters.Add("pass", OracleDbType.Varchar2).Value = param_cont.Value;

            cmd.ExecuteNonQuery();
            string respuesta = "Empleado creado";
            conn.Dispose();
            return respuesta;
        }

        public string Actualizar_Admin_DP(OracleConnection conn, int id_ad , string nom, string ape, 
                                                                    string fec_nac, string carg)
        {
            OracleParameter param_id = new OracleParameter();
            param_id.OracleDbType = OracleDbType.Varchar2;
            param_id.Value = id_ad;

            OracleParameter param_nom = new OracleParameter();
            param_nom.OracleDbType = OracleDbType.Varchar2;
            param_nom.Value = nom;

            OracleParameter param_apellido = new OracleParameter();
            param_apellido.OracleDbType = OracleDbType.Varchar2;
            param_apellido.Value = ape;

            OracleParameter param_fec_nac = new OracleParameter();
            param_fec_nac.OracleDbType = OracleDbType.Varchar2;
            param_fec_nac.Value = fec_nac;

            OracleParameter param_cargo = new OracleParameter();
            param_cargo.OracleDbType = OracleDbType.Varchar2;
            param_cargo.Value = carg;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "admin_update_dp";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("id_ad", OracleDbType.Int16).Value = param_id.Value;
            cmd.Parameters.Add("nom_ad", OracleDbType.Varchar2).Value = param_nom.Value;
            cmd.Parameters.Add("app_ad", OracleDbType.Varchar2).Value = param_apellido.Value;
            cmd.Parameters.Add("fec_nac", OracleDbType.Varchar2).Value = param_fec_nac.Value;
            cmd.Parameters.Add("cargo", OracleDbType.Varchar2).Value = param_cargo.Value;

            cmd.ExecuteNonQuery();
            string respuesta = "Empleado actualizado";
            conn.Dispose();
            return respuesta;
        }

        public string Actualizar_Admin_user(OracleConnection conn, int id_ad, string uss, string pass)
        {
            OracleParameter param_id = new OracleParameter();
            param_id.OracleDbType = OracleDbType.Varchar2;
            param_id.Value = id_ad;

            OracleParameter param_usuario = new OracleParameter();
            param_usuario.OracleDbType = OracleDbType.Varchar2;
            param_usuario.Value = uss;

            OracleParameter param_cont = new OracleParameter();
            param_cont.OracleDbType = OracleDbType.Varchar2;
            param_cont.Value = pass;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "admin_update_user";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("id_ad", OracleDbType.Int16).Value = param_id.Value;
            cmd.Parameters.Add("usuario", OracleDbType.Varchar2).Value = param_usuario.Value;
            cmd.Parameters.Add("pass", OracleDbType.Varchar2).Value = param_cont.Value;

            cmd.ExecuteNonQuery();
            string respuesta = "Usuario de empleado actualizado";
            conn.Dispose();
            return respuesta;
        }

        public string Ver_Admins(OracleConnection conn)
        {
            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;

            cmd.CommandText = "admin_read";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("cur_admin", OracleDbType.RefCursor).Direction = ParameterDirection.Output;


            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);

            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }

        public string Eliminar_ADMIN(OracleConnection conn, int id)
        {
            OracleParameter param_id = new OracleParameter();
            param_id.OracleDbType = OracleDbType.Varchar2;
            param_id.Value = id;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "admin_delete";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("id_ad", OracleDbType.Int16).Value = param_id.Value;
            cmd.ExecuteNonQuery();

            string respuesta = "Empleado eliminado";
            conn.Dispose();
            return respuesta;
        }
        public string Admin_Login(OracleConnection conn, string usuario, string contrasena)
        {

            OracleParameter param_usuario = new OracleParameter();
            param_usuario.OracleDbType = OracleDbType.Varchar2;
            param_usuario.Value = usuario;

            OracleParameter param_contrasena = new OracleParameter();
            param_contrasena.OracleDbType = OracleDbType.Varchar2;
            param_contrasena.Value = contrasena;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "LOGIN";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("us_nm", OracleDbType.Varchar2).Value = param_usuario.Value;
            cmd.Parameters.Add("passw", OracleDbType.Varchar2).Value = param_contrasena.Value;
            cmd.Parameters.Add("id_admin_us", OracleDbType.Int16).Direction = System.Data.ParameterDirection.Output;
            cmd.ExecuteNonQuery();

            string respuesta;
            respuesta = cmd.Parameters["id_admin_us"].Value.ToString();
            conn.Dispose();

            return respuesta;
        }
    }
}