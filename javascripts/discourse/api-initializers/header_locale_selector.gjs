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

    api.decorateWidget("post-menu:after", (helper) => {
      const attrs = helper.attrs;
      console.log("can_translate", attrs.id, attrs.can_translate, attrs);
      attrs.can_translate = true;

      return [];
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
