$('#edit-comf-<%= post.id%>').empty();
$('#edit-comf-<%= post.id%>').raty({
 starOff:  '<%= asset_path('star-off.png') %>',
 starOn : '<%= asset_path('star-on.png') %>',
 starHalf: '<%= asset_path('star-half.png') %>',
 score: <%= post.reviews.where(end_user_id: current_end_user.id).pluck(:rate) %>,
 scoreName: 'review[rate]',
 });