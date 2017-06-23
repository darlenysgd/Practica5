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

                    <div class="member_list aquiLaGente">

                            <div class="left clearfix userArea hidden">
                       <div class="chat-body clearfix">

                                    <div class="header_sec " >
                                        <strong class="primary-font userName"></strong>
                                    </div>
                                    </div>
                            </div>

                        </ul>
                    </div></div>
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
                            <div class="left clearfix aquiAbajo">
                                <div class="chat-body1 clearfix hidden " id="areaMensaje">
                                    <p class="cajaMensaje"></p>
                                </div>
                            </div>



                        </div>
                    </div><!--chat_area-->
                    <div class="message_write">
                        <textarea class="form-control" placeholder="type a message"></textarea>
                        <div class="clearfix"></div>
                        <div class="chat_bottom">
                            <a href="#" class="pull-right btn btn-success">
                                Send</a></div>
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


    $(document).ready(function() {
        conectar();
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
           // var usuarios = $()

            mensajeNuevo.removeClass("hidden");
            var mensajeRecibido = mensaje.data.split("~");
            mensajeNuevo.find(".cajaMensaje").html(mensajeRecibido[0]);

            $(".aquiAbajo").append(mensajeNuevo);
           // $(".aquiLaGente").append();


        }


    });


</script>

</html>
