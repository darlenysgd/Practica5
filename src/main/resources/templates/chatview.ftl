<#include "Includes/Header.ftl">

<script src="https://use.fontawesome.com/45e03a14ce.js"></script>
<div class="main_section">
    <div class="container">
        <div class="chat_container">
            <div class="col-sm-3 chat_sidebar">
                <div class="row">
                    <div id="custom-search-input">
                        <div class="input-group col-md-12">
                            <strong class="primary-font">Conversaciones:</strong>

                        </div>
                    </div>

                    <div class="member_list ">

                            <div class="left clearfix">
                       <div class="chat-body clearfix aquiLaGente">

                                    <div class="header_sec hidden" id="userArea">
                                        <br>
                                        <button class="userName btn btn-success" id="botonUsuario" ></button>
                                    </div>
                                    </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!--chat_sidebar-->


            <div class="col-sm-9 message_section">
                <div class="row">
                    <div class="new_message_head">
                        <div class="pull-left"></div><div class="pull-right"><div class="dropdown">


                    </div></div>
                    </div><!--new_message_head-->

                    <div class="chat_area">
                        <div class="list-unstyled">
                            <br>
                            <div class="left clearfix aquiAbajo ">
                                <div class="chat-body1 clearfix hidden zonaMensaje" id="areaMensaje">
                                    <strong class="cajaUsuario"></strong>
                                    <strong class="cajaUsuarioAdmin"></strong>
                                    <p class="cajaMensaje hidden"></p>
                                    <p class="cuerpoUsuario hidden" style="color:red"></p>
                                </div>
                            </div>



                        </div>
                    </div><!--chat_area-->
                    <div class="message_write">
                        <textarea class="form-control" id="mensajeAdmin" placeholder="Escriba su mensaje"></textarea>
                        <div class="clearfix"></div>
                        <div class="chat_bottom">
                            <button class="pull-right btn btn-success btn-block" id="boton">
                                Send</button></div>
                    </div>
                </div>
            </div> <!--message_section-->
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="row">
        <div class="col-lg-12">
            <p>Copyright &copy; Lit AF 2017</p>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
</footer>

</div>
<!-- /.container -->

<!-- jQuery -->
<script src="js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>

</body>

<script type="text/javascript">
    var webSocket;
    var usuario;
    var usuarioActual;


    $(document).ready(function() {
        conectar();


        $("#boton").click(function(){
            var mensaje = $("#mensajeAdmin");
            var mensajeNuevo = $("#areaMensaje").clone();

            mensajeNuevo.removeClass("hidden");
            mensajeNuevo.find(".cajaMensaje").removeClass("hidden");
            mensajeNuevo.find(".cajaMensaje").html(mensaje.val());
            mensajeNuevo.find(".cajaUsuario").html("Administrador");
            mensajeNuevo.find(".cajaUsuarioAdmin").html(usuario);
            $(".aquiAbajo").append(mensajeNuevo);
            webSocket.send(mensaje.val()+"~mensajeNuevoAdmin"+"~"+usuario);
            mensaje.val("");

        });


        function conectar() {
            webSocket = new WebSocket("ws://" + location.hostname + ":" + location.port + "/mensajeServidor");
            //indicando los eventos:
            webSocket.onmessage = function (data) {
                recibirInformacionServidor(data);
            };

            webSocket.onopen = function (e) {
                console.log("Conectado - status " + this.readyState);
                webSocket.send("naldjfalj~iniciarSesionAdmin");
            };
             webSocket.onclose = function (e) {
               console.log("Desconectado - status " + this.readyState);

            };

        }


        function recibirInformacionServidor(mensaje) {
            var mensajeNuevo = $("#areaMensaje").clone();
            var usuarios = $("#userArea").clone();
            var esta = false;
            usuarios.removeClass("hidden");
            mensajeNuevo.find(".cuerpoUsuario").removeClass("hidden");
            var mensajeRecibido = mensaje.data.split("~");
            usuario = mensajeRecibido[1];
            mensajeNuevo.find(".cuerpoUsuario").html(mensajeRecibido[0]);
            usuarios.find(".userName").html(mensajeRecibido[1]);
            mensajeNuevo.find(".cajaUsuario").html(mensajeRecibido[1]);
            $(".aquiAbajo").append(mensajeNuevo);
            if (mensajeRecibido[1] === usuarioActual){
                mensajeNuevo.removeClass("hidden");
            }
            $('.userName').each(function () {
                   if($(this).html() === usuario){
                    esta = true;
                }

            });


            if (esta === false) {
                $(".aquiLaGente").append(usuarios);
            }

        }

        $(document).on('click', '#botonUsuario', function(){
            var name = $(this).html();
            usuario = name;
            usuarioActual = name;

            $('.zonaMensaje').each(function () {
                if($(this).find(".cajaUsuario").html() !== name || $(this).find(".cajaUsuarioAdmin").html() !== name ){
                          $(this).addClass("hidden");
                            }
                if($(this).find(".cajaUsuario").html() === name || $(this).find(".cajaUsuarioAdmin").html() === name){
                    $(this).removeClass("hidden");
                }


            });


        });
    });


</script>

</html>
