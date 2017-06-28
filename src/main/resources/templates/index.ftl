<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Programación Web</title>

    <!-- Bootstrap Core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/css/blog-home.css" rel="stylesheet">

    <link href="/css/Estilos.css" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <script src="/js/MostrarArticulos.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script type="text/javascript" src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
         <script type="text/javascript" src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
         <script src="/js/bootstrap.min.js"></script>

    <![endif]-->

</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top topbar" role="navigation">
        <div class="container">

            <!-- Collect the nav links, forms, and other content for toggling -->


            <div class="collapse navbar-collapse topbar" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="/Home"><span class="dorado">Inicio</span></a>
                    </li>
                    <li>
                        <a href="/NuevoPost"><span class="dorado">Nueva entrada</span></a>
                    </li>
                    <li>
                        <a href="/NuevoUsuario"><span class="dorado">Registro</span></a>
                    </li>
                    <li>
                        <a href="/cerrarSesion"><span class="dorado">Cerrar Sesion</span></a>
                    </li>
                    <li>
                        <a href="/charRoom"><span class="dorado">Sala de Chat</span></a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Content -->
    <div class="container">

        <div class="row body-row">

            <!-- Blog Entries Column -->
            <div class="col-md-8">

                <h1 class="page-header">
                    Programación Web
                    <small>Práctica #3</small>
                </h1>

                <div id="VerArticulos">

                <#if vacio>
                    <#list articulos as art>

                        <h2>
                            <a href="/Entrada/${art_index}">${art.getTitulo()}</a>
                        </h2>
                        <p>
                            Autor: <a href="">${art.getAutor().getNombre()}</a>
                        </p>
                        <p><span class="glyphicon glyphicon-time"></span>${art.getFecha()}</p>
                        <hr>

                        <#assign cuerpo=art.getCuerpo()>
                        <#if cuerpo?length &lt; 70>
                        ${cuerpo}
                        <#else>
                        ${cuerpo?substring(0,70) + "..."}
                        </#if>

                        <br><br>
                        <a class="btn btn-primary" href="/Entrada/${art_index}">Leer Más<span class="glyphicon glyphicon-chevron-right"></span></a>

                        <hr>

                    </#list>
                </#if>

                </div>

                <div id="pagg"></div>
                <#if numPag gt 1 >
                    <form>
                        <button class="btn btn-icon" onclick="paginar2()">Anterior</button>
                    </form>


                </#if>
                <#if mas>
                    <form>
                        <button class="btn btn-icon" onclick="paginar()">Siguiente</button>
                    </form>
                </#if>
                <nav style="float:right;">

            </div>

            <!-- Blog Sidebar Widgets Column -->
            <div class="col-md-4">

                <!-- Blog Categories Well -->
                <div class="well">
                    <h4>Etiquetas: </h4>
                    <div class="row">
                        <div class="col-lg-12">
                            <#list etiquetas as et>
                            <a href="/HomePage/tags/${et_index}/${numPag}">${et.etiqueta}</a>
                            </#list>
                        </div>

                        <!-- /.col-lg-6 -->
                    </div>
                    <!-- /.row -->
                </div>
                
            </div>

        </div>
        <!-- /.row -->



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

    <!-- /.container -->
        <div class="chatbox chatbox--tray chatbox--empty">
            <div class="chatbox__title">
                <h5><a href="#">Chat</a></h5>
                <button class="chatbox__title__tray">
                    <span></span>
                </button>
                <button class="chatbox__title__close">
            <span>
                <svg viewBox="0 0 12 12" width="12px" height="12px">
                    <line stroke="#FFFFFF" x1="11.75" y1="0.25" x2="0.25" y2="11.75"></line>
                    <line stroke="#FFFFFF" x1="11.75" y1="11.75" x2="0.25" y2="0.25"></line>
                </svg>
            </span>
                </button>
            </div>
            <div class="chatbox__body">


                <div class="chatbox__body__message chatbox__body__message--left  hidden" id="area_chat"  >
                    <strong class="usuarioCaja"></strong>
                    <p class="cuerpo hidden"></p>
                    <p class="cuerpoAdmin hidden" style="color:red"></p>

                </div>
            </div>
            <div class="chatbox__credentials">
                <div class="form-group">
                    <label for="inputName">Ingresa tu nombre:</label>
                    <input type="text" class="form-control" id="inputName" required>
                </div>
                <button id="enviar" class="btn btn-success btn-block">Iniciar Chat</button>
            </div>
            <textarea   class="chatbox__message" id="mensajeCliente" placeholder="Escribe tu mensaje aqui"></textarea>
           <div class="chatbox__message">

                <button class="btn btn-success btn-block" id="boton">Enviar</button>
           </div>
           </div>


</body>

<script
        type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js">
</script>

<script type="text/javascript">

    var webSocket;
    var tiempoReconectar = 5000
    var usuario;

    $(document).ready(function(){
        conectar();
        $("#boton").click(function(){
            var mensaje = $("#mensajeCliente");
            var mensajeNuevo = $("#area_chat").clone();

            mensajeNuevo.removeClass("hidden");
            mensajeNuevo.find(".cuerpo").removeClass("hidden");
            mensajeNuevo.find(".cuerpo").html(mensaje.val());
            mensajeNuevo.find(".usuarioCaja").html("Tu:");
            $(".chatbox__body").append(mensajeNuevo);
            webSocket.send(mensaje.val()+"~mensajeNuevo");
            mensaje.val("");

        });


        function conectar() {
            webSocket = new WebSocket("ws://" + location.hostname + ":" + location.port + "/mensajeServidor");
            //indicando los eventos:
            webSocket.onmessage = function(data){recibirInformacionServidor(data);};
            webSocket.onopen  = function(e){ console.log("Conectado - status "+this.readyState); };
            webSocket.onclose = function(e){
                console.log("Desconectado - status "+this.readyState);
            };


        }

        function recibirInformacionServidor(mensaje) {

            var mensajeNuevo = $("#area_chat").clone();

            mensajeNuevo.removeClass("hidden");
            var mensajeRecibido = mensaje.data.split("~");
            mensajeNuevo.find(".cuerpoAdmin").removeClass("hidden");
            mensajeNuevo.find(".usuarioCaja").html("Administrador:");
            mensajeNuevo.find(".cuerpoAdmin").html(mensajeRecibido[0]);
            console.log(mensajeRecibido[0]);
            $(".chatbox__body").append(mensajeNuevo);

        }



            var $chatbox = $('.chatbox'),
                    $chatboxTitle = $('.chatbox__title'),
                    $chatboxTitleClose = $('.chatbox__title__close'),
                    $enviar = $('#enviar');
            $chatboxTitle.on('click', function() {
                $chatbox.toggleClass('chatbox--tray');
            });
            $chatboxTitleClose.on('click', function(e) {
                e.stopPropagation();
                $chatbox.addClass('chatbox--closed');
            });
            $chatbox.on('transitionend', function() {
                if ($chatbox.hasClass('chatbox--closed')) $chatbox.remove();
            });
            $enviar.on('click', function(e) {
                usuario = $("#inputName").val();
                webSocket.send($("#inputName").val()+"~iniciarSesion");
                e.preventDefault();
                $chatbox.removeClass('chatbox--empty');
            });



    });











</script>

</html>
