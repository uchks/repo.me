function getContentBlocks() {
  const bundleid = $.QueryString.p;

  return {
    "#packageName": {
      type: "text",
      source: "package>name",
    },
    "#packageHeader": {
      type: "custom",
      source: "package>name",
      render: (element, source) => {
        if (navigator.userAgent.search(/Cydia/) === -1) {
          $(element).show();
        }
      },
    },
    "#packageVersion": {
      type: "text",
      source: "package>version",
    },
    "#packageShortDesc": {
      type: "text",
      source: "package>shortDescription",
    },
    "#compatibilityCheck": {
      type: "custom",
      source: "package>compatibility>firmware",
      render: (element, source) => {
        const res = ios_version_check(
          $(source).find("miniOS").text(),
          $(source).find("maxiOS").text(),
          $(source).find("otherVersions").text(),
          (message, isBad) => {
            $(element)
              .html(message)
              .addClass(isBad ? "alert-danger" : "alert-success");
          }
        );
        if (res === 0) {
          $(element).hide();
        }
      },
    },
    "#descriptionList": {
      type: "list",
      source: "package>descriptionlist>description",
      paragraphElement: "<li class='list-group-item'>",
      emptyListCallback: (e) => {
        $("#descriptionPanel").hide();
      },
    },
    "#screenshotsLink": {
      type: "custom",
      source: "package>screenshots>screenshot",
      render: (element, source) => {
        $("#screenshotsLink").remove();
        if ($(source).length === 0) {
          return;
        }
        // create screenshots link
        $("#descriptionList").append(
          $("<a class='link-item list-group-item'>")
            .attr("href", `screenshots?p=${bundleid}`)
            .text("Screenshots")
        );
      },
    },
    "#versionBadge": {
      type: "text",
      source: "package>version",
    },
    "#changesList": {
      type: "list",
      source: "package>changelog>change",
      reverseRender: true,
      paragraphElement: "<li class='list-group-item'>",
      emptyListCallback: (e) => {
        $("#changesList").hide();
      },
    },
    "#changelogLink": {
      type: "custom",
      source: "package>changelog>change",
      render: (element, source) => {
        $("#changelogLink").remove();
        if ($(source).length === 0) {
          return;
        }
        // create changelog link
        $("#changesList").append(
          $("<a class='link-item list-group-item'>")
            .attr("href", `changelog?p=${bundleid}`)
            .text("Full Changelog")
        );
      },
    },
    "#dependencyList": {
      type: "list",
      source: "package>dependencies>package",
      paragraphElement: "<li class='list-group-item'>",
      emptyListCallback: (e) => {
        $("#dependenciesContainer").remove();
      },
    },
    "#externalLinksList": {
      type: "custom",
      source: "package>links>link",
      paragraphElement: "<li class='list-group-item'>",
      render: (element, source) => {
        if ($(source).length === 0) {
          $("#externalLinksContainer").remove();
          return;
        }

        $.each(source, (index, data) => {
          const a = $("<a class='link-item list-group-item'>");
          a.attr("href", $(data).find("url").text());
          if ($(data).find("iconclass").length) {
            const i = $("<span>");
            i.attr("class", $(data).find("iconclass").text());
            $(a).append(i);
          }
          $(a).append($(data).find("name").text());
          $(element).append(a);
        });
      },
    },
  };
}

function populateContentBlocks(data, blocks, error, success) {
  $.ajax({
    type: "GET",
    dataType: "xml",
    url: data,
    success: (xml) => {
      data_loader_engine(blocks, xml);
      success(xml);
    },
    cache: false,
    error: (jqXHR, textStatus) => {
      $("#packageError").show();
      $("#packageInformation").hide();
      error(textStatus);
    },
  });
}
