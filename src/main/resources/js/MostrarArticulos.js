/**
 * Created by darle on 6/25/2017.
 */


function paginar(){

    $.get("/HomeNext", function (data) {
        $("#VerArticulos").html(data)
        
    })
}


function paginar3() {

    $.get("/HomeBack", function (data) {
        $("#VerArticulos").html(data)

    })

}
