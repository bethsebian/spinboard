$(document).ready(function() {
  listAllLinks();
  changeStatus();
  filterByStatus();
  showAll();
});

function listAllLinks() {
  return $.getJSON('api/v1/links.json').then(function (links) {
    collectAndFormatLinks(links);
  });
}

function collectAndFormatLinks(links) {
  var target = $('#links-list');
  var renderedLinks = links.map(renderLink);
  $(target).append('<div class="links-container"></div>');
  var target2 = $('.links-container');
  $(target2).append(renderedLinks);
}

function renderLink(link) {
  return $(
    '<div class="link_info '
    + (link.read_status === true ? 'read' : 'unread' )
    + '" id="link_'
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
    + '" >'
    + (link.read_status === true ? ('<button class="change-status" id=' + link.id + '>Mark as Unread</button>') : ('<button class="change-status" id=' + link.id + '>Mark as Read</button>'))
    + '<a href="/links/'
    + link.id
    + '/edit">Edit</a>'
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

function filterByStatus() {
  $(".filter-buttons").delegate('.filter-by-status', 'click', function() {
    filterLinks(this.id);
  });
}

function showAll() {
  $(".filter-buttons").delegate('.show-all', 'click', function() {
    $('.links-container').remove();
    listAllLinks();
  });
}

function filterLinks(filterType) {
  return $.getJSON("api/v1/links?status=" + filterType).then(function (links) {
    $('.links-container').remove();
    collectAndFormatLinks(links);
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
    var linkDiv = document.getElementById('link_' + link.id);
    linkDiv.remove();
    $('#links-list').append(renderLink(link));
  });
}
