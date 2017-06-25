package Servicios;




        import org.eclipse.jetty.websocket.api.Session;
        import org.eclipse.jetty.websocket.api.annotations.OnWebSocketClose;
        import org.eclipse.jetty.websocket.api.annotations.OnWebSocketConnect;
        import org.eclipse.jetty.websocket.api.annotations.OnWebSocketMessage;
        import org.eclipse.jetty.websocket.api.annotations.WebSocket;
        import static j2html.TagCreator.*;
        import j2html.TagCreator;
        import j2html.tags.ContainerTag;
        import java.io.IOException;
        import java.util.ArrayList;
        import java.util.HashMap;
        import java.util.List;

/**
 * Representa la clase para enviar información desde el servidor al cliente.
 * Created by vacax on 06/06/16.
 */
@WebSocket
public class ServidorMensajesWebSocketHandler {
    public static List<Session> usuariosConectados = new ArrayList<>();
    public static HashMap <Session, String> usuarios = new HashMap<>();
    public static HashMap <String, Session> sesiones = new HashMap<>();
    public static Session sesionAdmin;

    /**
     * Una vez conectado el cliente se activa este metodo.
     * @param usuario
     */
    @OnWebSocketConnect
    public void conectando(Session usuario){
        System.out.println("Conectando Usuario: "+usuario.getLocalAddress().getAddress().toString());
        usuariosConectados.add(usuario);
    }

    /**
     * Una vez cerrado la conexión, es ejecutado el metodo anotado
     * @param usuario
     * @param statusCode
     * @param reason
     */
    @OnWebSocketClose
    public void cerrandoConexion(Session usuario, int statusCode, String reason) {
        System.out.println("Desconectando el usuario: "+usuario.getLocalAddress().getAddress().toString());
        usuariosConectados.remove(usuario);
    }

    /**
     * Una vez recibido un mensaje es llamado el metodo anotado.
     * @param usuario
     * @param message
     */
    @OnWebSocketMessage
    public void recibiendoMensaje(Session usuario, String message) {


        System.out.println("Recibiendo del cliente: "+usuario.getLocalAddress().getAddress().toString()+" - Mensaje "+message);
        try {

          String[] mensaje = message.split("~") ;



              System.out.println(mensaje[0]);
              System.out.println(mensaje[1]);


               switch (mensaje[1]){

                case "iniciarSesion":
                    usuarios.put(usuario, mensaje[0].trim());
                    sesiones.put(mensaje[0].trim(), usuario);
                    break;
                case "iniciarSesionAdmin":
                    System.out.println("Se inicio la melma");

                    sesionAdmin = usuario;
                    break;
                case "mensajeNuevo":

                    if(sesionAdmin != null){
                        System.out.println(mensaje[0]);
                        sesionAdmin.getRemote().sendString(mensaje[0] +"~"+ usuarios.get(usuario) );
                    }
                    break;

                case "mensajeNuevoAdmin":
                    String destino = mensaje[2];

                    Session sesionDestino = sesiones.get(destino);
                    if(sesionDestino != null){
                        System.out.println(destino);
                        sesionDestino.getRemote().sendString(mensaje[0] +"~"+sesiones.get(usuario));
                    }
                    break;


            }




        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void enviarMensajeAClientesConectados(String mensaje, String color){
        for(Session sesionConectada : usuariosConectados){
            try {
                sesionConectada.getRemote().sendString(p(mensaje).withClass(color).render());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}