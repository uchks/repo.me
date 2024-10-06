function getContentBlocks() {
  const bundleid = $.QueryString.p;

  return {
    "#screenshotsList": {
      type: "custom",
      source: "package>screenshots>screenshot",
      render: (element, source) => {
        if ($(source).length === 0) {
          $(element).append(
            $(
              "<div class='alert alert-danger'>There aren't any screenshots for this package</div>"
            )
          );
          return;
        }

        $.each(source, (index, data) => {
          const th = $("<div class='thumbnail'>");
          th.append($("<p>").text($(data).find("description").text()));
          th.append(
            $('<img class="img-fluid">').attr(
              "src",
              `${bundleid}/screenshots/${$(data).find("image").text()}`
            )
          );
          $(element).append(th);
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
