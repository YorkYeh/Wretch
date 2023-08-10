import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';
import { patch } from '@rails/request.js'

// Connects to data-controller="sort"
export default class extends Controller {
  initialize(){
    this.sortable = null
  }
  connect() {
    this.sortablele = new Sortable(this.element,{
      ghostClass: "drag-ghost",
      onEnd: (e)=> {
        const {item,oldIndex,newIndex} = e
        if (oldIndex !== newIndex){
          //patch  sort_album /albums/:id/sort(.:format) albums#sort
          const { id } = item.dataset
          this.sortItem(id,newIndex);
        }
  
      }
    })
  }

  disconnect(){
    this.sortable = null
  }
  
  async sortItem(id,newIndex) {
    const endpoint = `/albums/${id}/sort`;
    const data = { body: JSON.stringify({ position: newIndex + 1 }) };



   
    const response = await patch(endpoint, data);
    if (response.ok) {
      console.log('ok')
    }else {
      console.log('fail')
    }
  }
}
