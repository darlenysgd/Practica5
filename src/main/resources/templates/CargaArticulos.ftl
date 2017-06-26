
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

