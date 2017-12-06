def country_select2(value, **_options)
  find('span.select2').click
  find(:xpath, '//body').find('.select2-search input.select2-search__field').set(value)
  page.execute_script(%|$("input.select2-search__field:visible").keyup();|)
  find(:xpath, '//body').find('.select2-dropdown li.select2-results__option', text: value).click
end
