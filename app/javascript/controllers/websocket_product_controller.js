//Se suprime al utilizar el codigo de turbo
/*
import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
//connect es lo primero que se ejecuta
connect() {
    //Para probar si ejecuta 
    //alert('ok')
    //Establece la comunicacion a un canal ProductChannel
    createConsumer().subscriptions.create({ channel: "ProductChannel", room: this.element.dataset.productid }, 
    //Callback es la accion que se va ejecutar cuando se reciba el mensaje
    {
        received(data) {
        if (data.action === "updated") {
          location.reload()
        }
      }
    })
  }
}
*/