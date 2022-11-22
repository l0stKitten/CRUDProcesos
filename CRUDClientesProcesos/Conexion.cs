using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Oracle.ManagedDataAccess.Client;

namespace CRUDClientesProcesos
{
    public class Conexion
    {
        OracleConnection oc;
        string oradb = "DATA SOURCE=localhost:1521/xe;PERSIST SECURITY INFO=True;USER ID=DARIA; PASSWORD=daria"; // establece conexion con el servidor
        public Conexion()
        {
        }

        public void EstablecerConnection()
        {
            oc = new OracleConnection(oradb);
            oc.Open();

        }

        public OracleConnection GetConexion()
        {
            return oc;
        }
    }
}