import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {

  static targets = [ "likebtn" ]

  connect(){
    const { id, liked } = this.element.dataset;
    this.id = id;

    if (liked === "true"){
      this.likebtnTarget.textContent = "收回讚";
    }else{
      this.likebtnTarget.textContent = "讚";
    }
  }

  toggle(e) { 

    e.preventDefault();

    const url = `/api/v1/articles/${this.id}/like`
    const token = document.querySelector("meta[name=csrf-token]").content
 
    fetch(url, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": token,
        },
      })
      .then((resp) =>{
      
        return resp.json();
      })
      .then(({ liked }) => {
        if (liked){
          this.likebtnTarget.textContent = "收回讚";
        } else {
          this.likebtnTarget.textContent = "讚";
        }
      })
      .catch((err)=>{
        console.log(err)
        
      });
   }

  // static targets = ["count"];

  // hi(){
  //   const currentCount = Number(this.countTarget.textContent)
  //   this.countTarget.textContent = currentCount + 1 ;

  //   if(currentCount >= 5){
  //     const o = {detail: { cc: currentCount}}
  //     const evt = new CustomEvent("abc",o);
  //     window.dispatchEvent(evt)
  //   }
  // }
}
