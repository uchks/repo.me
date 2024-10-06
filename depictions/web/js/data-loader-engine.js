function data_loader_engine(contentBlocks, xml) {
  /* Loop through each if the contentBlocks */
  $.each(contentBlocks, (key, contentInfo) => {
    console.log(`Processing ${key}`);
    console.log(`  type= ${contentInfo.type}`);

    // go out if key element does not exits
    if (!$(key).length) {
      return;
    }

    switch (contentInfo.type) {
      case "text": {
        const content = $(xml).find(contentInfo.source).text();
        $(key).html(content);
        break;
      }
      case "link": {
        console.log(`  url= ${contentInfo.url}`);
        console.log(`  text= ${contentInfo.text}`);

        let url = contentInfo.url;
        const params = [];
        if (contentInfo.params) {
          $.each(contentInfo.params, function () {
            this[1] = escape(this[1]);
            params[params.length] = this.join("=");
          });
        }
        url = `${url}?${params.join("&")}`;
        $(key).append($("<a></a>").attr("href", url).text(contentInfo.text));
        break;
      }
      case "list": {
        let list = $(xml).find(contentInfo.source);

        if (list.length === 0) {
          if (contentInfo.emptyListCallback) {
            contentInfo.emptyListCallback($(key));
          }
        } else {
          if (contentInfo.reverseRender) {
            list = $(list).get().reverse();
          }
          $.each(list, (index, value) => {
            const item = $(value).text();

            if (contentInfo.reverseRender) {
              $(key).prepend(
                $(contentInfo.paragraphElement).html(`<p>${item}</p>`)
              );
            } else {
              $(key).append(
                $(contentInfo.paragraphElement).html(`<p>${item}</p>`)
              );
            }
          });
        }
        break;
      }
      case "articles": {
        const articles = $(xml).find(contentInfo.source).children();
        let titleID = 0;
        $.each(articles, (index, article) => {
          const articleTitle = $(article).find(contentInfo.titleSource).text();
          $(key).append($(contentInfo.titleElement).html(articleTitle));
          const container = $(contentInfo.paragraphContainer).attr(
            "id",
            ++titleID
          );
          $(key).append($(container));
          $.each(
            $(article).find(contentInfo.paragraphSource),
            (index, paragraph) => {
              $(container).append(
                $(contentInfo.paragraphElement).html(
                  `<p>${$(paragraph).text()}</p>`
                )
              );
            }
          ); //paragraph
        }); //article

        break;
      }
      case "custom":
        if (!key) {
          return;
        }
        contentInfo.render($(key), $(xml).find(contentInfo.source));
        break;
    } //switch
  }); //each
}
