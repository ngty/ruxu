var ruxu = {

  browser : null,

  open : function(url) {
    this.browser = window.openDialog(url);
  },

  $ : function(id) {
    return this.browser.document.getElementById(id);
  },

  findByTagAndAttrs : function (tag, attrs) {
    var cxt = arguments.length>2 ? arguments[2] : this.browser.document;
    var t_nodes = cxt.getElementsByTagName(tag),
        a_nodes = utils.$X("/descendant::*[" + this._concatAttrs(attrs) + "]", cxt);
    return this._commonNodes(t_nodes, a_nodes);
  },

  _commonNodes : function (x_nodes, y_nodes) {
    var f_nodes = [];
    for (var i = 0; i < x_nodes.length; ++i) {
      for (var j = 0; j < y_nodes.length; ++j) {
        this._injectId(x_nodes[i]);
        if (x_nodes[i].id == y_nodes[j].id) {
          f_nodes.push(x_nodes[i]);
        };
      };
    };
    return f_nodes;
  },

  _concatAttrs : function (attrs) {
    var exprs = [];
    for (k in attrs) {
      exprs.push("@" + k + "=\"" + attrs[k] + "\"");
    };
    return exprs.join(" and ");
  },

  _injectId : function(node) {
    if(!node.id) {
      node.id = node.nodeName + '-' + (new UUID());
    };
  }

};

