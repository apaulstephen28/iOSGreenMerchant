<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
		$(document).ready(function() {
  var $accordian = $('.js-accordian');
  var $items = $('.js-item');

    // set even click on the whole accordian and then check for js-item
  // this way you pair down how much is being watched
  $accordian.on('click', '.js-item', function() {
    console.log( $(this).data('name') );
    // just to show data-attributes for fun

    $items.removeClass('open');
    $(this).addClass('open'); // the item you clicked...
  });
});
	</script>
	<title></title>
	<style type="text/css">
		.accordian {
  list-style: none;
  margin: 0;
  padding: 0;
  background: black;
}

.accordian .item {
  background: lightgray;
}

.accordian .content {
  height: 0;
  overflow: hidden;
}

.accordian .content p {
  margin: 0;
  padding: .5rem;
  background: white;
}

.accordian .item.open .content {
  height: auto;
}
	</style>
</head>
<body>
<ul class='accordian js-accordian'>

  <li class='item js-item' data-name='one'>
    <button>open me</button>
    <div class='content'>
      <iframe>This is some content. It could be an iFrame or whatever you want. - but you'll have to set the height for an iFrame.</iframe>
    </div>
  </li>

  <li class='item js-item' data-name='two'>
    <button>open me</button>
    <div class='content'>
      <iframe>This is some content. It could be an iFrame or whatever you want. - but you'll have to set the height for an iFrame.</iframe>
    </div>
  </li>

</ul>
</body>
</html>