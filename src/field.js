var field = function(value, label, type) {
  this.id = null;
  this.label = label;
  this.value = value;
  this.message = "";  
  this.cssClass = "";
  this.type = type || "text";
};

module.exports = field;