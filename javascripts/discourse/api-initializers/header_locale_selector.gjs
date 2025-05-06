import { ajax } from "discourse/lib/ajax";
import { apiInitializer } from "discourse/lib/api";
import LocaleSelector from "../components/locale-selector";

export default apiInitializer("1.8.0", (api) => {
  const siteSettings = api.container.lookup("site-settings:main");
  const currentUser = api.getCurrentUser();

  if (currentUser && siteSettings.allow_user_locale) {
    api.headerIcons.add(
      "locale-selector",
      <template>
        <li class="header-locale-selector-widget"><LocaleSelector /></li>
      </template>,
      {
        before: api.headerIcons.has("chat") ? "chat" : "search",
      }
    );

    api.onPageChange(() => {
      document.querySelectorAll(".topic-post").forEach((post) => {
        const postMenu = post.querySelector(".post-controls");

        if (postMenu && !postMenu.querySelector(".translate-btn")) {
          const btn = document.createElement("button");
          btn.innerText = "Traduire";
          btn.className = "btn btn-icon translate-btn";
          btn.addEventListener("click", () => {
            const postId = post.dataset.postId;
            // appel ajax ici avec postId
          });
          postMenu.appendChild(btn);
        }
      });
    });

    // api.reopenWidget("post-menu", {
    //   didRenderWidget() {
    //     if (!this.attrs.can_translate) {
    //       return;
    //     }

    //     if (this.state.isTranslated) {
    //       return;
    //     }

    //     if (this.state.isTranslating) {
    //       return;
    //     }

    //     if (this.state.translateError) {
    //       return;
    //     }

    //     this.state.isTranslated = true;
    //     this.state.isTranslating = true;
    //     this.scheduleRerender();
    //     const post = this.findAncestorModel();

    //     ajax("/translator/translate", {
    //       type: "POST",
    //       data: { post_id: post.get("id") },
    //     })
    //       .then(function (res) {
    //         post.setProperties({
    //           translated_text: res.translation,
    //           detected_lang: res.detected_lang,
    //         });
    //       })
    //       .finally(() => {
    //         this.state.isTranslating = false;
    //         this.scheduleRerender();
    //       })
    //       .catch((error) => {
    //         this.state.isTranslated = false;
    //         this.state.translateError = true;
    //         this.scheduleRerender();
    //       });
    //   },
    // });
  }
});
