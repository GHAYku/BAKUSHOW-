('#star-rate-<%= review.id %>').empty();
('#star-rate-<%= review.id %>').raty({
 starOn: "<%= asset_path('star-on.png') %>",
 starOff: "<%= asset_path('star-off.png') %>",
 starHalf: "<%= asset_path('star-half.png') %>",
 scoreName: 'review[rate]'
 });