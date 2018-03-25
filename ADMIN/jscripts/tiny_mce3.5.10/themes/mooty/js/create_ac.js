$('#category_ac').change(function(){
var field=$('.extra_field')
var name=$('#name').val();
var cat_ac_id=$('#category_ac').val();
if(cat_ac_id == 72)
{
	$(field).append('<label>Stock/Product Code</label><input class="form-control" id="stock_code"> ')
}
if(cat_ac_id == 65)
{
	$(field).append('<label>Stock/Product Code</label><input class="form-control" id="stock_code"> ')
}

});