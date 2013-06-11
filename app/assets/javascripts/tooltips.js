$(document).ready(function()
{
    tooltip = $('.tooltip')
    tooltip_handles = tooltip.find('.handle')
    tooltip_handles.click(function(event){
        event.preventDefault();
    });
    tooltip.find(".content").hide();
    tooltip_handles.each(function()
    {
        $(this).qtip({
            content: $(this).parent('.tooltip').find('.content').clone().html(),
        });
    });
});
