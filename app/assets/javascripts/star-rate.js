(function($) {
('#star-rate-<%= post.id %>').empty();
('#star-rate-<%= post.id %>').raty({
 starOn: "<%= asset_path('star-on.png') %>",
 starOff: "<%= asset_path('star-off.png') %>",
 starHalf: "<%= asset_path('star-half.png') %>",
 scoreName: 'review[rate]'
 });
});