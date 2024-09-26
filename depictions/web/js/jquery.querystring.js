(($) => {
  $.QueryString = ((a) => {
    if (a === "") return {};
    const b = {};
    for (let i = 0; i < a.length; ++i) {
      const p = a[i].split("=");
      if (p.length !== 2) continue;
      b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
  })(window.location.search.substr(1).split("&"));
})(jQuery);
