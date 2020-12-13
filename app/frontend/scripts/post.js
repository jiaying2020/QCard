// 送參數給/posts/7/favorite，有回應的話給我訊息，失敗也給我訊息
// then處理成功catch處理失敗

// then 是一種promise
// 跑完DOMConyentLoaded執行byn的工作
// POST /posts/7/favorite
// 如何在js抓外部id

document.addEventListener("DOMContentLoaded", function() {
    const favorite_btn = document.querySelector('#favorite_btn')

    if (favorite_btn) {
        favorite_btn.addEventListener("click", function(e) {
            e.preventDefault()

            // 打 API / 送資料 / AJAX
            // POST /posts/7/favorite
            const ax = require('axios')
            const token = document.querySelector('[name=csrf-token]').content
            ax.defaults.headers.common['X-CSRF-TOKEN'] = token

            const postId = e.currentTarget.dataset.id
            const icon = e.target

            ax.post(`/posts/${postId}/favorite`, {})
                .then(function(resp) {
                    if (resp.data.status == "added") {
                        icon.classList.remove("far")
                        icon.classList.add("fas")
                    } else {
                        icon.classList.remove("fas")
                        icon.classList.add("far")
                    }
                })
                .catch(function(err) {
                    console.log(err);
                })

        })
    }
})


// 這裡寫if是指定有btn的情況下再做
// 為了不要跳轉網頁
// 而只要在該<a>觸發的事件中加入event.preventDefault()，就不會在執行他默認的動作，也就是不會再執行「連結到某個網址」這個動作。
// 這時候雖然我們執行了事件，但是他還是會執行該DOM本身的功能，也就是跳轉網頁，preventDefault()！我們在下方把他加進去！
// 就算點了也不會跳轉網頁！因為在事件中把該DOM預設功能給取消了！取消瀏覽器的預設行為。