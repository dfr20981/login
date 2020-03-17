import mysql.connector

mydb = mysql.connector.connect{
  host="localhost",
  user="root",
  passwd="",
  database="p_login"
}

conexion = mysql.connector.connect(**mydb)
cursor = conexion.cursor()
sql = "SELECT name, Lname, username, email, id_p FROM usuarios"

cursor.execute(sql)

resultados = cursor.fetchall()

print(resultados)
