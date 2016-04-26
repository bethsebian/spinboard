$(document).ready(function() {
  listAllLinks();
  changeStatus();
});

function listAllLinks() {
  var target = $('#links-list');
  return $.getJSON('api/v1/links.json').then(function (links) {
    collectAndFormatLinks(links, target);
  });
}

function collectAndFormatLinks(links, target) {
  var renderedLinks = links.map(renderLink);
  $(target).append(renderedLinks);
}

function renderLink(link) {
  return $(
    '<div class="link_info" id="link_'
    + link.id
    + '" ><br>Url: '
    + link.url
    + '<br>Title: '
    + link.title
    + '<br>Read: <div id="status_'
    + link.id
    + '_parent" ><div id="status_'
    + link.id
    + '_child" >'
    + link.read_status
    + '</div></div><br><br><div id="status_button_'
    + link.id
    + '" ><button class="change-status" id=' + link.id + ' name="change-status">Change Status</button>'
    + '</div>'
  );
}

function changeStatus() {
  $("#links-list").delegate(".change-status", 'click', function() {
    var linkId = this.id
    updateStatusInModel(linkId);
    updateStatusInView(linkId);
  });
}

function updateStatusInModel(linkId) {
  $.ajax({
    type: "put",
    url: "/api/v1/links/" + linkId + ".json",
    data: { "change_type": "read_status" },
    success: function(link) {
      console.log('Link status successfully updated in database.');
    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });
}

function updateStatusInView(linkId) {
  getUpdatedLinkInfo(linkId);
}



function getUpdatedLinkInfo(linkId) {
  $.ajax({
    type: "get",
    dataType: "json",
    url: "/api/v1/links/" + linkId + ".json",
    success: function(link) {
      console.log('Link status successfully updated in view.');    }
  }).then(function (link) {
    var newStatus = link.read_status;
    var statusParent = document.getElementById('status_' + linkId + '_parent');
    var statusChild = document.getElementById('status_' + linkId + '_child');
    statusChild.remove();
    console.log(link.id);
    console.log(link.read_status);
    $(statusParent).append('<div id="status_' + link.id + '_child" >' + link.read_status+ '</div>');
    // $('status_' + linkId + '_parent').append("hello") // '<div id="status_' + link.id + '_child" >' + link.read_status+ '</div>');
  });
}
