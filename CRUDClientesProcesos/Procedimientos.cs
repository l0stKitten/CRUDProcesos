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
        /*public DataSet Ver_Productos(OracleConnection conn)
        {
            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            //cmd.CommandText = "read_productos";
            cmd.CommandText = "SELECT * FROM PRODUCTO";
            cmd.CommandType = System.Data.CommandType.Text;
            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);
            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }*/

        public string Ver_Productos(OracleConnection conn)
        {
            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;

            //cmd.CommandText = "SELECT * FROM PRODUCTO";
            //cmd.CommandType = System.Data.CommandType.Text;
            cmd.CommandText = "read_productos";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("cur_prod", OracleDbType.RefCursor).Direction = ParameterDirection.Output;


            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);

            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }
    }
}