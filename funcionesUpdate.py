import mysql.connector

def actualizar_campo_por_id(tabla, id_a_actualizar, campo, nuevo_valor):
  try:
      conexion = mysql.connector.connect(
          user='tu_usuario',
          password='tu_contraseña',
          host='localhost',
          database='tu_base_de_datos',
          raise_on_warnings=True
      )
      cursor = conexion.cursor()

      # Ejecutar la actualización
      consulta = f"UPDATE {tabla} SET {campo} = %s WHERE id = %s"
      cursor.execute(consulta, (nuevo_valor, id_a_actualizar))

      # Confirmar los cambios y cerrar la conexión
      conexion.commit()
      print(f"Campo '{campo}' actualizado correctamente para el registro con ID {id_a_actualizar}.")

  except mysql.connector.Error as err:
      print(f"Error: {err}")

  finally:
      if 'conexion' in locals() and conexion.is_connected():
          cursor.close()
          conexion.close()



def actualizar_campo_por_usuario(tabla, usuarioEspol, campo, nuevo_valor):
  try:
      conexion = mysql.connector.connect(
          user='tu_usuario',
          password='tu_contraseña',
          host='localhost',
          database='tu_base_de_datos',
          raise_on_warnings=True
      )
      cursor = conexion.cursor()

      # Ejecutar la actualización
      consulta = f"UPDATE {tabla} SET {campo} = %s WHERE id = %s"
      cursor.execute(consulta, (nuevo_valor, usuarioEspol))

      # Confirmar los cambios y cerrar la conexión
      conexion.commit()
      print(f"Campo '{campo}' actualizado correctamente para el registro con ID {usuarioEspol}.")

  except mysql.connector.Error as err:
      print(f"Error: {err}")

  finally:
      if 'conexion' in locals() and conexion.is_connected():
          cursor.close()
          conexion.close()