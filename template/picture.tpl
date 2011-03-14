{* Example of resizeable *}
{*
{include file='include/autosize.inc.tpl'}
*}
{if isset($errors)}
<div class="errors">
  <ul>
    {foreach from=$errors item=error}
    <li>{$error}</li>
    {/foreach}
  </ul>
</div>
{/if}

{if isset($infos)}
<div class="infos">
  <ul>
    {foreach from=$infos item=info}
    <li>{$info}</li>
    {/foreach}
  </ul>
</div>
{/if}
{if !empty($PLUGIN_PICTURE_BEFORE)}{$PLUGIN_PICTURE_BEFORE}{/if}

<div id="imageHeaderBar">
  <div class="browsePath">
    {$SECTION_TITLE}
    {$LEVEL_SEPARATOR}{$current.TITLE}
  </div>
  <div class="imageNumber">{$PHOTO}</div>
  {if $SHOW_PICTURE_NAME_ON_TITLE }
  <h2>{$current.TITLE}</h2>
  {/if}
</div>

<div id="imageToolBar">
  <div class="randomButtons">
    {if isset($U_SLIDESHOW_START) }
      <a href="{$U_SLIDESHOW_START}" title="{'slideshow'|@translate}" rel="nofollow"><img src="{$ROOT_URL}{$themeconf.icon_dir}/start_slideshow.png" class="button" alt="{'slideshow'|@translate}"></a>
    {/if}
    {if isset($U_METADATA) }
      <a href="{$U_METADATA}" title="{'Show file metadata'|@translate}" rel="nofollow"><img src="{$ROOT_URL}{$themeconf.icon_dir}/metadata.png" class="button" alt="metadata"></a>
    {/if}
    {if isset($current.U_DOWNLOAD) }
      <a href="{$current.U_DOWNLOAD}" title="{'download this file'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/save.png" class="button" alt="{'download'|@translate}"></a>
    {/if}
    {if isset($PLUGIN_PICTURE_ACTIONS)}{$PLUGIN_PICTURE_ACTIONS}{/if}
    {if isset($favorite) }
      <a href="{$favorite.U_FAVORITE}" title="{if $favorite.IS_FAVORITE}{'delete this image from your favorites'|@translate}{else}{'add this image to your favorites'|@translate}{/if}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/{if $favorite.IS_FAVORITE}del_favorite{else}favorite{/if}.png" class="button" alt="favorite" title="{if $favorite.IS_FAVORITE}{'delete this image from your favorites'|@translate}{else}{'add this image to your favorites'|@translate}{/if}"></a>
    {/if}
    {if !empty($U_SET_AS_REPRESENTATIVE) }
      <a href="{$U_SET_AS_REPRESENTATIVE}" title="{'set as category representative'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/representative.png" class="button" alt="{'representative'|@translate}"></a>
    {/if}
    {if isset($U_ADMIN) }
      <a href="{$U_ADMIN}" title="{'Modify information'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/preferences.png" class="button" alt="{'edit'|@translate}"></a>
    {/if}
    {if isset($U_CADDIE) }{*caddie management BEGIN*}
<script type="text/javascript">
{literal}function addToCadie(aElement, rootUrl, id)
{
if (aElement.disabled) return;
aElement.disabled=true; 
var y = new PwgWS(rootUrl);

y.callService(
  "pwg.caddie.add", {image_id: id} ,
  {
    onFailure: function(num, text) { alert(num + " " + text); document.location=aElement.href; },
    onSuccess: function(result) { aElement.disabled = false; }
  }
  );
}{/literal}
</script>
      <a href="{$U_CADDIE}" onclick="addToCadie(this, '{$ROOT_URL|@escape:'javascript'}', {$current.id}); return false;" title="{'add to caddie'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/caddie_add.png" class="button" alt="{'caddie'|@translate}"></a>
    {/if}{*caddie management END*}
  </div>
  {include file='picture_nav_buttons.tpl'|@get_extent:'picture_nav_buttons'}
</div> <!-- imageToolBar -->

<div id="theImage">

{assign var='largeur' value=$element_info['scaled_width']}
{*
<div id="action_pict" style="width:{$largeur}" >
    {if isset($U_SLIDESHOW_START) }
      <a href="{$U_SLIDESHOW_START}" title="{'slideshow'|@translate}" rel="nofollow"><img src="{$ROOT_URL}{$themeconf.icon_dir}/start_slideshow.png" class="button" alt="{'slideshow'|@translate}"></a>
    {/if}
    {if isset($U_SLIDESHOW_STOP) }
      <a href="{$U_SLIDESHOW_STOP}" title="{'slideshow_stop'|@translate}" rel="nofollow"><img src="{$ROOT_URL}{$themeconf.icon_dir}/stop_slideshow.png" class="button" alt="{'slideshow_stop'|@translate}"></a>
    {/if}
      <a href="{$U_METADATA}" title="{'picture_show_metadata'|@translate}" rel="nofollow"><img src="{$ROOT_URL}{$themeconf.icon_dir}/metadata.png" class="button" alt="metadata" /></a>
    {if isset($current.U_DOWNLOAD) }
      <a href="{$current.U_DOWNLOAD}" title="{'download_hint'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/save.png" class="button" alt="{'download'|@translate}"></a>
    {/if}
    {if isset($PLUGIN_PICTURE_ACTIONS)}{$PLUGIN_PICTURE_ACTIONS}{/if}
    {if isset($favorite) }
      <a href="{$favorite.U_FAVORITE}" title="{$favorite.FAVORITE_HINT}"><img src="{$favorite.FAVORITE_IMG}" class="button" alt="favorite" title="{$favorite.FAVORITE_HINT}"></a>
    {/if}
    {if isset($COMMENT_COUNT)}
      <a href="#comments" title="{'comment'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/menu/chat.png" class="button" alt="{'comment'|@translate}"></a>
    {/if}


	{if isset($rating)}

    <span id="updateRate">{if isset($rating.USER_RATE)}{'Update your rating'|@translate}{else}{'Rate this picture'|@translate}{/if}</span>
			
            			<form action="{$rating.F_ACTION}" method="post" id="rateForm" style="margin:0;">
			<div>&nbsp;
			{foreach from=$rating.marks item=mark name=rate_loop}
			{if !$smarty.foreach.rate_loop.first} | {/if}
			{if isset($rating.USER_RATE) && $mark==$rating.USER_RATE}
			  <input type="button" name="rate" value="{$mark}" class="rateButtonSelected" title="{$mark}">
			{else}
			  <input type="submit" name="rate" value="{$mark}" class="rateButton" title="{$mark}">
			{/if}
			{/foreach}
			<script type="text/javascript" src="{$ROOT_URL}themes/default/js/rating.js"></script>
			<script type="text/javascript">
			makeNiceRatingForm( {ldelim}rootUrl: '{$ROOT_URL|@escape:"javascript"}', image_id: {$current.id},
			updateRateText: "{'Update your rating'|@translate|@escape:'javascript'}", updateRateElement: document.getElementById("updateRate"),
			ratingSummaryText: "{'%.2f (rated %d times)'|@translate|@escape:'javascript'}", ratingSummaryElement: document.getElementById("ratingSummary") {rdelim} );
			</script>
			</div>
			</form>

{/if}

</div> *}
{$ELEMENT_CONTENT}
{if isset($COMMENT_IMG)}
<p>{$COMMENT_IMG}</p>
{/if}

{if isset($U_SLIDESHOW_STOP) }
<p>
  [ <a href="{$U_SLIDESHOW_STOP}">{'slideshow_stop'|@translate}</a> ]
</p>
{/if}

</div>

<table id="standard" class="infoTable" summary="{'Some info about this picture'|@translate}">
  {if $display_info.author}
  <tr id="Author">
    <td class="label">{'Author'|@translate}</td>
    <td class="value">{if isset($INFO_AUTHOR)}{$INFO_AUTHOR}{else}{'N/A'|@translate}{/if}</td>
  </tr>
  {/if}
  {if $display_info.created_on}
  <tr id="datecreate">
    <td class="label">{'Created on'|@translate}</td>
    <td class="value">{if isset($INFO_CREATION_DATE)}{$INFO_CREATION_DATE}{else}{'N/A'|@translate}{/if}</td>
  </tr>
  {/if}
  {if $display_info.posted_on}
  <tr id="datepost">
    <td class="label">{'Posted on'|@translate}</td>
    <td class="value">{$INFO_POSTED_DATE}</td>
  </tr>
  {/if}
  {if $display_info.dimensions}
  <tr id="Dimensions">
    <td class="label">{'Dimensions'|@translate}</td>
    <td class="value">{if isset($INFO_DIMENSIONS)}{$INFO_DIMENSIONS}{else}{'N/A'|@translate}{/if}</td>
  </tr>
  {/if}
  {if $display_info.file}
  <tr id="File">
    <td class="label">{'File'|@translate}</td>
    <td class="value">{$INFO_FILE}</td>
  </tr>
  {/if}
  {if $display_info.filesize}
  <tr id="Filesize">
    <td class="label">{'Filesize'|@translate}</td>
    <td class="value">{if isset($INFO_FILESIZE)}{$INFO_FILESIZE}{else}{'N/A'|@translate}{/if}</td>
  </tr>
  {/if}
  {if $display_info.tags}
  <tr id="Tags">
    <td class="label">{'Tags'|@translate}</td>
    <td class="value">
      {if isset($related_tags)}
        {foreach from=$related_tags item=tag name=tag_loop}{if !$smarty.foreach.tag_loop.first}, {/if}
        <a href="{$tag.URL}">{$tag.name}</a>{/foreach}
      {/if}
    </td>
  </tr>
  {/if}
  {if $display_info.categories}
  <tr id="Categories">
    <td class="label">{'Categories'|@translate}</td>
    <td class="value">
      {if isset($related_categories)}
      <ul>
        {foreach from=$related_categories item=cat}
        <li>{$cat}</li>
        {/foreach}
      </ul>
      {/if}
    </td>
  </tr>
  {/if}
  {if $display_info.visits}
  <tr id="Visits">
    <td class="label">{'Visits'|@translate}</td>
    <td class="value">{$INFO_VISITS}</td>
  </tr>
  {/if}

{if $display_info.average_rate and isset($rate_summary) }
	<tr id="Average">
		<td class="label">{'Average rate'|@translate}</td>
		<td class="value" id="ratingSummary">
		{if $rate_summary.count}
			{assign var='rate_text' value='%.2f (rated %d times)'|@translate }
			{$pwg->sprintf($rate_text, $rate_summary.average, $rate_summary.count) }
		{else}
			{'no rate'|@translate}
		{/if}
		</td>
	</tr>
{/if}
  
{if isset($rating)}
	<tr id="rating">
		<td class="label">
			<span id="updateRate">{if isset($rating.USER_RATE)}{'Update your rating'|@translate}{else}{'Rate this picture'|@translate}{/if}</span>
		</td>
		<td class="value">
			<form action="{$rating.F_ACTION}" method="post" id="rateForm" style="margin:0;">
			<div>&nbsp;
			{foreach from=$rating.marks item=mark name=rate_loop}
			{if !$smarty.foreach.rate_loop.first} | {/if}
			{if isset($rating.USER_RATE) && $mark==$rating.USER_RATE}
			  <input type="button" name="rate" value="{$mark}" class="rateButtonSelected" title="{$mark}">
			{else}
			  <input type="submit" name="rate" value="{$mark}" class="rateButton" title="{$mark}">
			{/if}
			{/foreach}
			<script type="text/javascript" src="{$ROOT_URL}themes/default/js/rating.js"></script>
			<script type="text/javascript">
			makeNiceRatingForm( {ldelim}rootUrl: '{$ROOT_URL|@escape:"javascript"}', image_id: {$current.id},
			updateRateText: "{'Update your rating'|@translate|@escape:'javascript'}", updateRateElement: document.getElementById("updateRate"),
			ratingSummaryText: "{'%.2f (rated %d times)'|@translate|@escape:'javascript'}", ratingSummaryElement: document.getElementById("ratingSummary") {rdelim} );
			</script>
			</div>
			</form>
		</td>
	</tr>
{/if}

{if $display_info.privacy_level and isset($available_permission_levels) }
	<tr id="Privacy">
		<td class="label">{'Who can see this photo?'|@translate}</td>
		<td class="value"> 
<script type="text/javascript">
{literal}function setPrivacyLevel(selectElement, rootUrl, id, level)
{
selectElement.disabled = true;
var y = new PwgWS(rootUrl);
y.callService(
	"pwg.images.setPrivacyLevel", {image_id: id, level:level} ,
	{
		method: "POST",
		onFailure: function(num, text) { selectElement.disabled = false; alert(num + " " + text); },
		onSuccess: function(result) { selectElement.disabled = false; }
	}
	);
}{/literal}
</script>
	<select onchange="setPrivacyLevel(this, '{$ROOT_URL|@escape:'javascript'}', {$current.id}, this.options[selectedIndex].value)">
		{foreach from=$available_permission_levels item=label key=level}
		<option label="{$label}" value="{$level}"{if $level == $current.level} selected="selected"{/if}>{$label}</option>
		{/foreach}
	</select>
	</td></tr>
{/if}

</table>

{if isset($metadata)}
<table id="Metadata" class="infoTable2" summary="{'Some more (technical) info about this picture'|@translate}">
{foreach from=$metadata item=meta}
  <tr>
    <th colspan="2">{$meta.TITLE}</th>
  </tr>
  {foreach from=$meta.lines item=value key=label}
  <tr>
    <td class="label">{$label}</td>
    <td class="value">{$value}</td>
  </tr>
  {/foreach}
{/foreach}
</table>
{/if}

<hr class="separation">

{if isset($COMMENT_COUNT)}
<div id="comments">
  {if $COMMENT_COUNT > 0}
		<h3>{$pwg->l10n_dec('%d comment', '%d comments',$COMMENT_COUNT)}</h3>
  {/if}
	{if !empty($COMMENT_NAV_BAR)}
	<div class="navigationBar">{$COMMENT_NAV_BAR}</div>
	{/if}

	{if isset($comments)}
		{include file='comment_list.tpl' comment_separator=true}
	{/if}

	{if isset($comment_add)}
	<form  method="post" action="{$comment_add.F_ACTION}" class="filter" id="addComment">
	<fieldset>
		<legend>{'Add a comment'|@translate}</legend>
		{if $comment_add.SHOW_AUTHOR}
		<label>{'Author'|@translate}<input type="text" name="author"></label>
		{/if}
		<label>{'Comment'|@translate}<textarea name="content" id="contentid" rows="5" cols="80">{$comment_add.CONTENT}</textarea></label>
		<input type="hidden" name="key" value="{$comment_add.KEY}" />
		<input type="submit" type="submit" value="{'Submit'|@translate}">
	</fieldset>
	</form>
	{/if}
</div>
{/if} {*comments*}



{if !empty($PLUGIN_PICTURE_AFTER)}{$PLUGIN_PICTURE_AFTER}{/if}
