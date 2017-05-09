set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.3.00.03'
,p_default_workspace_id=>1301105260114689
,p_default_application_id=>83009
,p_default_owner=>'SCOTT'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/region_type/com_planetapex_circliful_gauge
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(7951224823997243)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.PLANETAPEX.CIRCLIFUL_GAUGE'
,p_display_name=>'Circliful Gauge'
,p_supported_ui_types=>'DESKTOP'
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#js/jquery.circliful.min.js',
'#PLUGIN_FILES#js/circlifulGauge.min.js'))
,p_css_file_urls=>'#PLUGIN_FILES#css/jquery.circliful.min.css'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'',
'  /****************************************************************************************',
'  ****************************************************************************************',
'  **  Plugin      : Circliful Gauge',
'  **  InternalName: COM.PLANETAPEX.CIRCLIFUL_GUAGE',
'  **  Author      : M.Yasir Ali Shah',
'  **  Date        : Saturday, April 29, 2017',
'  **  Version     : 1.0',
'  **  Description : The plugin is will show Percentage Graph',
'  **  Modification:',
'  **  Change Log  1) 1.0 - Initial Release -                                 ',
'  **  gitHub Repo : https://github.com/planetapex/apex-plugin-circlifulGauge',
'  **  Website     : https://apexfusion.blogspot.com/  **  ',
'  ****************************************************************************************',
'  ****************************************************************************************/',
'',
'  g_title_col   constant number(1) := 1;',
'  g_percent_col constant number(1) := 2;',
'  g_target_col  constant number(1) := 3;',
'  g_icon_col    constant number(1) := 4;',
'  g_dispVal_col constant number(1) := 5;',
'  -- g_value_col   constant number(1) := 3;',
'',
'  FUNCTION f_yn_2_truefalse(p_val IN VARCHAR2) RETURN boolean AS',
'  BEGIN',
'    RETURN case NVL(p_val, ''N'') when ''Y'' then true else false end;',
'  END f_yn_2_truefalse;',
'',
'  function f_render(p_region              in apex_plugin.t_region,',
'                    p_plugin              in apex_plugin.t_plugin,',
'                    p_is_printer_friendly in boolean)',
'    return apex_plugin.t_region_render_result is',
'    l_render_result apex_plugin.t_region_render_result;',
'  ',
'    -- Region Plugin Attributes ',
'    -----------------------------------------',
'    subtype attr is p_region.attribute_01%type;',
'  ',
'    -- atr_start_row boolean := f_yn_2_truefalse(p_region.attribute_0);',
'  ',
'    atr_templ INTEGER := TO_NUMBER(p_region.attribute_02);',
'  ',
'    l_html    varchar2(32767);',
'    l_js_code varchar2(32767);',
'    v_Options varchar2(32767); --Options per Chart',
'  ',
'  begin',
'  ',
' /*   apex_css.add_file(p_name      => ''jquery.circliful'',',
'                      p_directory => apex_application.g_image_prefix ||',
'                                     ''libraries/circa/css/'');*/',
'  ',
'    apex_json.initialize_clob_output;',
'    apex_json.open_object; --{',
'  ',
'    apex_json.open_array(''chart'');',
'    apex_json.open_object;',
'    apex_json.close_object;',
'    apex_json.close_array;',
'  ',
'    apex_json.write(''ajaxIdentifier'', apex_plugin.get_ajax_identifier);',
'    apex_json.write(''pageItems'',',
'                    apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit));',
'    apex_json.write(''templateNo'', atr_templ);',
'    apex_json.write(''noDataFoundMessage'', p_region.no_data_found_message);',
'  ',
'    /* if l_col_val_list(l_col_val_list.first).value_list.count = 0 then',
'      apex_json.write(''noData'', true);',
'    else',
'      apex_json.write(''noData'', false);',
'    end if;*/',
'  ',
'    apex_json.close_object;',
'    v_Options := apex_json.get_clob_output;',
'  ',
'    apex_json.free_output;',
'  ',
'    /*  apex_application.show_error_message(p_message => ''asd'',',
'    p_footer  =>apex_json.get_clob_output );*/',
'  ',
'    l_js_code := ''apex.jQuery("#'' || p_region.static_id ||',
'                 ''").circlifulGauge('' || v_Options || '');'';',
'  ',
'    apex_javascript.add_onload_code(p_code => l_js_code);',
'  ',
'    return l_render_result;',
'  ',
'  end f_render;',
'',
'  function f_ajax(p_region in apex_plugin.t_region,',
'                  p_plugin in apex_plugin.t_plugin)',
'    return apex_plugin.t_region_ajax_result is',
'    l_ajax_result apex_plugin.t_region_ajax_result;',
'  ',
'    atr_col_span APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_01,',
'                                                                              '','');',
'  ',
'    atr_title_color   APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_03,',
'                                                                                   '','');',
'    atr_title_style   APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_04,',
'                                                                                   ''^'');',
'    atr_title_XY      APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_05,',
'                                                                                   '','');',
'    atr_title_curr_XY APEX_APPLICATION_GLOBAL.VC_ARR2;',
'  ',
'    atr_animation_step APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_06,',
'                                                                                    '','');',
'  ',
'    atr_perc_txt_size APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_07,',
'                                                                                   '','');',
'  ',
'    atr_perc_XY_pos APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_08,',
'                                                                                 '','');',
'  ',
'    atr_perc_curr_XY_pos APEX_APPLICATION_GLOBAL.VC_ARR2;',
'  ',
'    atr_half_circle APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_09,',
'                                                                                 '','');',
'  ',
'    atr_perc_font_color APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_10,',
'                                                                                     '','');',
'    atr_perc_decimals   APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_11,',
'                                                                                     '','');',
'    atr_targ_font_color APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_12,',
'                                                                                     '','');',
'  ',
'    atr_targ_font_size APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_13,',
'                                                                                    '','');',
'  ',
'    atr_icon APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_14,',
'                                                                          '','');',
'  ',
'    atr_icon_size APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_15,',
'                                                                               '','');',
'  ',
'    atr_icon_color APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_16,',
'                                                                                '','');',
'  ',
'    atr_icon_position APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_17,',
'                                                                                   '','');',
'  ',
'    atr_circ_perc_size         APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_18,',
'                                                                                            '','');',
'    atr_circ_perc_color        APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_19,',
'                                                                                            '','');',
'    atr_circ_perc_outer_color  APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_20,',
'                                                                                            '','');',
'    atr_circ_main_color        APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_21,',
'                                                                                            '','');',
'    atr_circ_main_border_width APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_22,',
'                                                                                            '','');',
'    atr_perc_circum_seg_color  APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_23,',
'                                                                                            '','');',
'    atr_perc_circum_seg_width  APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_24,',
'                                                                                            '','');',
'    atr_Options                APEX_APPLICATION_GLOBAL.VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(p_region.attribute_25,',
'                                                                                            '':'');',
'  ',
'    --Options for the plugin',
'    ---------------------------------------',
'    -- v_Options clob;     ',
'  ',
'    l_arr_lst APEX_APPLICATION_GLOBAL.VC_ARR2;',
'    l_val     varchar2(32767);',
'  ',
'    l_tk  APEX_APPLICATION_GLOBAL.VC_ARR2;',
'    l_opt APEX_APPLICATION_GLOBAL.VC_ARR2;',
'  ',
'    TYPE ass_tab IS TABLE OF VARCHAR2(100);',
'    aar_opts   ass_tab;',
'    aar_sels   ass_tab := ass_tab();',
'    aar_unsels ass_tab := ass_tab();',
'    l_idx      Integer;',
'  ',
'    -- code variables',
'    -------------------',
'    l_html    varchar2(32767);',
'    l_js_code varchar2(32767);',
'  ',
'    l_crlf char(2) := chr(13) || chr(10);',
'  ',
'    --LIST QUERY',
'    l_title   varchar2(32767);',
'    l_percent Number(14);',
'    l_target  Number(14);',
'    l_icon    varchar2(32767);',
'    l_dispVal varchar2(32767);',
'  ',
'    l_query              clob;',
'    l_lst_type           varchar2(50);',
'    l_col_data_type_list apex_application_global.vc_arr2;',
'    l_col_val_list       apex_plugin_util.t_column_value_list2;',
'  ',
'  begin',
'  ',
'    apex_plugin_util.print_json_http_header;',
'    apex_json.initialize_output(p_http_cache => false);',
'    -- begin output as json',
'    /* owa_util.mime_header(''application/json'', false);',
'    htp.p(''cache-control: no-cache'');',
'    htp.p(''pragma: no-cache'');',
'    owa_util.http_header_close; */',
'  ',
'    apex_json.open_object; --{',
'    apex_json.open_array(''chart'');',
'  ',
'    -- Read the data based on the region source query',
'    -- In the query',
'    -- the first column is the title(null or ''...'' and string',
'    -- the 2nd column is the percentage value(0 or greater) and number',
'    -- the 3rd column is the Target percentage value(0 or greater) and number',
'    -- the 4th column is the font awesome icon(null or icon name) and string  ',
'  ',
'    l_col_data_type_list(g_title_col) := apex_plugin_util.c_data_type_varchar2;',
'    l_col_data_type_list(g_percent_col) := apex_plugin_util.c_data_type_number;',
'    l_col_data_type_list(g_target_col) := apex_plugin_util.c_data_type_number;',
'    l_col_data_type_list(g_icon_col) := apex_plugin_util.c_data_type_varchar2;',
'    l_col_data_type_list(g_dispVal_col) := apex_plugin_util.c_data_type_varchar2;',
'  ',
'    --',
'  ',
'    l_col_val_list := apex_plugin_util.get_data2(p_sql_statement  => p_region.source,',
'                                                 p_min_columns    => 2,',
'                                                 p_max_columns    => 5,',
'                                                 p_data_type_list => l_col_data_type_list,',
'                                                 p_component_name => p_region.name);',
'  ',
'    /*apex_application.show_error_message(p_message => ''this'',',
'    p_footer  => l_col_val_list(l_col_val_list.first).value_list.count',
'    );*/',
'    For i in 1 .. l_col_val_list(l_col_val_list.first).value_list.count loop',
'      l_title   := null;',
'      l_percent := 0;',
'      l_icon    := ''none'';',
'      l_target  := 0;',
'      l_dispVal := null;',
'    ',
'      apex_plugin_util.set_component_values(p_column_value_list => l_col_val_list,',
'                                            p_row_num           => i);',
'    ',
'      ---Template--',
'      --=======================',
'      apex_json.open_object;',
'      apex_json.write(''colSpan'',',
'                      case when atr_col_span.exists(i) AND',
'                      atr_col_span(i) is NOT NULL AND',
'                      TO_NUMBER(atr_col_span(i)) between 1 and 12 then',
'                      atr_col_span(i) else 3 end);',
'    ',
'      --==Query Columns and Main Values==---  ',
'      ---------------------------------',
'      l_title := sys.htf.escape_sc(l_col_val_list(g_title_col).value_list(i)',
'                                   .varchar2_value);',
'    ',
'      l_percent := sys.htf.escape_sc(l_col_val_list(g_percent_col).value_list(i)',
'                                     .number_value);',
'    ',
'      if l_col_val_list.exists(g_target_col) then',
'        l_target := sys.htf.escape_sc(l_col_val_list(g_target_col).value_list(i)',
'                                      .number_value);',
'      end if;',
'    ',
'      if l_col_val_list.exists(g_icon_col) and l_col_val_list(g_icon_col).value_list(i)',
'        .varchar2_value is not null then',
'        l_icon := sys.htf.escape_sc(l_col_val_list(g_icon_col).value_list(i)',
'                                    .varchar2_value);',
'      elsif atr_icon.exists(i) and atr_icon(i) is not null then',
'        l_icon := sys.htf.escape_sc(atr_icon(i));',
'      end if;',
'    ',
'      if l_col_val_list.exists(g_dispVal_col) then',
'        l_dispVal := sys.htf.escape_sc(l_col_val_list(g_dispVal_col).value_list(i)',
'                                       .varchar2_value);',
'      end if;',
'    ',
'      ---==Icons====-----',
'      -----------------------------------',
'      if l_icon != ''none'' then',
'      ',
'        apex_json.write(''iconColor'',',
'                        case when atr_icon_color.exists(i) then',
'                        atr_icon_color(i) end);',
'      ',
'        apex_json.write(''iconSize'',',
'                        case when',
'                        atr_icon_size.exists(i) AND',
'                        wwv_flow_utilities.is_numeric(atr_icon_size(i)) then',
'                        atr_icon_size(i) end);',
'      ',
'        apex_json.write(''iconPosition'',',
'                        case when atr_icon_position.exists(i) then',
'                        atr_icon_position(i) end);',
'      ',
'      end if;',
'    ',
'      apex_json.write(''text'', l_title);',
'      apex_json.write(''percent'', l_percent);',
'      apex_json.write(''targetPercent'', l_target);',
'      apex_json.write(''iconFA'', l_icon);',
'      apex_json.write(''replacePercentageByText'', l_dispVal);',
'    ',
'      --End "Query Columns and Main Values"',
'      -------------------------------------------------------',
'    ',
'      apex_json.write(''textStyle'',',
'                      case when atr_title_style.exists(i) then',
'                      atr_title_style(i) end);',
'    ',
'      atr_title_curr_XY(1) := null;',
'      atr_title_curr_XY(2) := null;',
'    ',
'      if atr_title_XY.exists(i) AND atr_title_XY(i) is Not null AND',
'         InStr('':'' || p_region.attribute_25 || '':'', '':1:'') <= 0 then',
'      ',
'        atr_title_curr_XY := APEX_UTIL.STRING_TO_TABLE(atr_title_XY(i), '';'');',
'      ',
'        apex_json.write(''textY'',',
'                        case when atr_title_curr_XY.exists(1) then',
'                        atr_title_curr_XY(1) end);',
'      ',
'        apex_json.write(''textX'',',
'                        case when atr_title_curr_XY.exists(2) then',
'                        atr_title_curr_XY(2) end);',
'      ',
'      end if;',
'    ',
'      apex_json.write(''textColor'',',
'                      case when atr_title_color.exists(i) then',
'                      atr_title_color(i) end);',
'    ',
'      apex_json.write(''percentageTextSize'',',
'                      case when atr_perc_txt_size.exists(i) then',
'                      atr_perc_txt_size(i) end);',
'    ',
'      if atr_perc_XY_pos.exists(i) AND atr_perc_XY_pos(i) is Not null then',
'        atr_perc_curr_XY_pos(1) := null;',
'        atr_perc_curr_XY_pos(2) := null;',
'        atr_perc_curr_XY_pos := APEX_UTIL.STRING_TO_TABLE(atr_perc_XY_pos(i),',
'                                                          '';'');',
'      ',
'        apex_json.write(''percentageY'',',
'                        case when atr_perc_curr_XY_pos.exists(1) then',
'                        atr_perc_curr_XY_pos(1) end);',
'        apex_json.write(''percentageX'',',
'                        case when atr_perc_curr_XY_pos.exists(2) then',
'                        atr_perc_curr_XY_pos(2) end);',
'      ',
'      end if;',
'    ',
'      apex_json.write(''fontColor'',',
'                      case when atr_perc_font_color.exists(i) then',
'                      atr_perc_font_color(i) end);',
'    ',
'      apex_json.write(''decimals'',',
'                      case when atr_perc_decimals.exists(i) then',
'                      atr_perc_decimals(i) end);',
'      apex_json.write(''targetTextSize'',',
'                      case when',
'                      atr_targ_font_size.exists(i) AND',
'                      wwv_flow_utilities.is_numeric(atr_targ_font_size(i)) then',
'                      atr_targ_font_size(i) end);',
'    ',
'      apex_json.write(''targetColor'',',
'                      case when atr_targ_font_color.exists(i) then',
'                      atr_targ_font_color(i) end);',
'    ',
'      ---===Circles====',
'      ---------------------------------',
'      apex_json.write(''pointSize'',',
'                      case when',
'                      atr_circ_perc_size.exists(i) AND',
'                      wwv_flow_utilities.is_numeric(atr_circ_perc_size(i)) then',
'                      To_number(atr_circ_perc_size(i)) end);',
'    ',
'      apex_json.write(''pointColor'',',
'                      case when atr_circ_perc_color.exists(i) then',
'                      atr_circ_perc_color(i) end);',
'    ',
'      apex_json.write(''fillColor'',',
'                      case when atr_circ_perc_outer_color.exists(i) then',
'                      atr_circ_perc_outer_color(i)',
'                      ',
'                      end);',
'    ',
'      apex_json.write(''backgroundColor'',',
'                      case when atr_circ_main_color.exists(i) then',
'                      atr_circ_main_color(i)',
'                      ',
'                      end);',
'    ',
'      apex_json.write(''backgroundBorderWidth'',',
'                      case when atr_circ_main_border_width.exists(i) then',
'                      atr_circ_main_border_width(i) end);',
'    ',
'      apex_json.write(''foregroundColor'',',
'                      case when atr_perc_circum_seg_color.exists(i) then',
'                      atr_perc_circum_seg_color(i) end);',
'    ',
'      apex_json.write(''foregroundBorderWidth'',',
'                      case when atr_perc_circum_seg_width.exists(i) then',
'                      atr_perc_circum_seg_width(i) end);',
'    ',
'      apex_json.write(''animationStep'',',
'                      case when',
'                      atr_animation_step.exists(i) AND',
'                      wwv_flow_utilities.is_numeric(atr_animation_step(i)) then',
'                      ',
'                      to_number(atr_animation_step(i)) end);',
'    ',
'      apex_json.write(''halfCircle'',',
'                      case when atr_half_circle.exists(i) then',
'                      f_yn_2_truefalse(atr_half_circle(i)) end);',
'    ',
'      /*',
'      Options in the plugin have display values for options e,g toggleSelected'',''autoClose'',''keyboardNav'' ',
'      with return values as 1,2,3,4....',
'      Here the aar_opts is populated with the actula JS option for the corresponding Plugin Display Option value',
'      so their index 1,2,3 ….. are synced      ',
'      */',
'      aar_opts := ass_tab(''textBelow'',',
'                          ''animation'',',
'                          ''animateInView'',',
'                          ''alwaysDecimals'',',
'                          ''showPercent'',',
'                          ''noPercentageSign'',',
'                          ''multiPercentage'');',
'      --populate the selected options in the aar_sels varray, since atr_Options(i)[plugin opt attr] will return',
'      --the return values of the selected as ,2,5,8....  ',
'      --So the aar_opts(2) = autoClose ,  aar_opts(5) = clearButton ',
'    ',
'      FOR i IN 1 .. atr_Options.count LOOP',
'        aar_sels.extend;',
'      ',
'        aar_sels(i) := aar_opts(to_NUMBER(atr_Options(i)));',
'      END LOOP;',
'      aar_unsels := aar_opts MULTISET except aar_sels;',
'    ',
'      l_idx := aar_sels.first;',
'      while (l_idx is not null) loop',
'        IF aar_sels(l_idx) = ''animation'' OR aar_sels(l_idx) = ''showPercent'' OR',
'           aar_sels(l_idx) = ''multiPercentage'' then',
'          apex_json.write(aar_sels(l_idx), 1);',
'        ELSE',
'          apex_json.write(aar_sels(l_idx), true);',
'        ENd If;',
'        l_idx := aar_sels.next(l_idx);',
'      end loop;',
'      l_idx := aar_unsels.first;',
'      while (l_idx is not null) loop',
'        IF aar_unsels(l_idx) in',
'           (''animation'', ''showPercent'', ''multiPercentage'') then',
'          apex_json.write(aar_unsels(l_idx), 0);',
'        ELSE',
'          apex_json.write(aar_unsels(l_idx), false);',
'        ENd If;',
'      ',
'        l_idx := aar_unsels.next(l_idx);',
'      end loop;',
'    ',
'      apex_json.close_object;',
'    End loop;',
'  ',
'    apex_json.close_array;',
'  ',
'    apex_json.write(''pageItems'',',
'                    apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit));',
'  ',
'    apex_json.close_object;',
'  ',
'    apex_plugin_util.clear_component_values;',
'  ',
'    return null;',
'    /*exception',
'    when others then',
'      htp.p(''error: '' || apex_escape.html(sqlerrm));',
'      return null;*/',
'  end f_ajax;'))
,p_render_function=>'f_render'
,p_ajax_function=>'f_ajax'
,p_standard_attributes=>'SOURCE_SQL:SOURCE_REQUIRED:AJAX_ITEMS_TO_SUBMIT:NO_DATA_FOUND_MESSAGE:COLUMNS'
,p_sql_min_column_count=>1
,p_sql_max_column_count=>5
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/planetapex/apex-plugin-circlifulGauge'
,p_files_version=>5
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8070983431455131)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Column Span(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8081988751398606)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>2
,p_prompt=>'Chart Template'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'1'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8082597491402111)
,p_plugin_attribute_id=>wwv_flow_api.id(8081988751398606)
,p_display_sequence=>10
,p_display_value=>'No Template'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8083005883405464)
,p_plugin_attribute_id=>wwv_flow_api.id(8081988751398606)
,p_display_sequence=>20
,p_display_value=>'Card Template'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8083394039406776)
,p_plugin_attribute_id=>wwv_flow_api.id(8081988751398606)
,p_display_sequence=>30
,p_display_value=>'Standard Template with Title'
,p_return_value=>'3'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7988469994908713)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Title Color(s)'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'commar-separared lis of valid colours values.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7993489749526707)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Title CSS Style'
,p_attribute_type=>'HTML'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8026896340606376)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Title From Top(Y);Left(X) (s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_unit=>'CSV(Colon-SV)'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8045329535064634)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Animation Step(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_unit=>'CSV'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8004698996868691)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Percent Text Size'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_unit=>'comma-separated integer'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8006718411908645)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Percentage Value From Top(Y);Left(X) (s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8045904697068626)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Half Circle'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_unit=>'CSV'
,p_is_translatable=>false
,p_text_case=>'UPPER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8011586947116006)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Percent Font Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8013304443176596)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Percentage Decimals Precision'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8019811367342545)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Target Value Font Color(s)'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8020385629345327)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Target Value Font Size(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8020987948353528)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Icon(s)'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8022253794451300)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>150
,p_prompt=>'Icon Size(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8022853075452662)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>160
,p_prompt=>'Icon Color(s)'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8023442447453469)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>170
,p_prompt=>'Icon Position(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_text_case=>'LOWER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8023975288466454)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>180
,p_prompt=>'Inner Circle Size(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8024642278467980)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>190
,p_prompt=>'Inner Circle Color(s)'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8032415427777471)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>200
,p_prompt=>'Middle Circle Color(s)'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8032981233783413)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>210
,p_prompt=>'Outer Circle Color(s)'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8033646728786972)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>220
,p_prompt=>'Outer Circle Border Width(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
end;
/
begin
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8034198700790308)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>23
,p_display_sequence=>230
,p_prompt=>'Percent Circumferential Segment Color(s)'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8034818240792019)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>240
,p_prompt=>'Percent Circumferential Segment Width(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8054404418388325)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>25
,p_display_sequence=>250
,p_prompt=>'Options:'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>true
,p_default_value=>'2:5'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8054990839389938)
,p_plugin_attribute_id=>wwv_flow_api.id(8054404418388325)
,p_display_sequence=>10
,p_display_value=>'Text Below'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8055470981391293)
,p_plugin_attribute_id=>wwv_flow_api.id(8054404418388325)
,p_display_sequence=>20
,p_display_value=>'Animation'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8055776691392704)
,p_plugin_attribute_id=>wwv_flow_api.id(8054404418388325)
,p_display_sequence=>30
,p_display_value=>'Animation InView'
,p_return_value=>'3'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8056207400394465)
,p_plugin_attribute_id=>wwv_flow_api.id(8054404418388325)
,p_display_sequence=>40
,p_display_value=>'Animation with decimals'
,p_return_value=>'4'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8056615524395759)
,p_plugin_attribute_id=>wwv_flow_api.id(8054404418388325)
,p_display_sequence=>50
,p_display_value=>'Show Percent'
,p_return_value=>'5'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8056983009397165)
,p_plugin_attribute_id=>wwv_flow_api.id(8054404418388325)
,p_display_sequence=>60
,p_display_value=>'No Percent Sign'
,p_return_value=>'6'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8057417994398710)
,p_plugin_attribute_id=>wwv_flow_api.id(8054404418388325)
,p_display_sequence=>70
,p_display_value=>'Multi Percentage'
,p_return_value=>'7'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E636972636C6966756C202E696E6E65722C2E636972636C6966756C202E6F757465727B66696C6C3A7472616E73706172656E743B7472616E736974696F6E3A7374726F6B652D646173686F66667365742031733B2D7765626B69742D616E696D617469';
wwv_flow_api.g_varchar2_table(2) := '6F6E2D706C61792D73746174653A72756E6E696E673B2D6D6F7A2D7472616E73666F726D3A726F74617465282D383964656729207472616E736C61746558282D3139307078297D2E636972636C6966756C202E6F757465727B7374726F6B653A23333333';
wwv_flow_api.g_varchar2_table(3) := '3B7374726F6B652D77696474683A31392E383B7374726F6B652D6461736861727261793A3533347D2E636972636C6966756C202E696E6E65727B7374726F6B653A6F72616E67653B7374726F6B652D77696474683A32303B7374726F6B652D6461736861';
wwv_flow_api.g_varchar2_table(4) := '727261793A3533343B7374726F6B652D646173686F66667365743A307D2E636972636C6966756C7B6F766572666C6F773A76697369626C6521696D706F7274616E747D2E7376672D636F6E7461696E65727B77696474683A313030253B6D617267696E3A';
wwv_flow_api.g_varchar2_table(5) := '30206175746F3B6F766572666C6F773A76697369626C657D737667202E69636F6E7B666F6E742D66616D696C793A466F6E74417765736F6D657D2E612D436972636C6947617567652D6E6F44617461466F756E642D636F6E7461696E65727B706F736974';
wwv_flow_api.g_varchar2_table(6) := '696F6E3A72656C61746976653B626F726465723A31707820736F6C696420234643303B626F782D73697A696E673A626F726465722D626F783B6261636B67726F756E643A234646433B636F6C6F723A233338344633343B666F6E742D7765696768743A37';
wwv_flow_api.g_varchar2_table(7) := '30303B6D617267696E3A327078206175746F20313470783B70616464696E673A3135707821696D706F7274616E743B746578742D616C69676E3A63656E7465723B766572746963616C2D616C69676E3A6D6964646C653B6F766572666C6F773A68696464';
wwv_flow_api.g_varchar2_table(8) := '656E3B746578742D6F766572666C6F773A656C6C69707369737D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(8155497745364140)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_file_name=>'css/jquery.circliful.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2166756E6374696F6E28652C662C612C6F297B612E776964676574282275692E636972636C6966756C4761756765222C7B6F7074696F6E733A7B63686172743A5B7B636F6C5370616E3A337D5D2C616A61784964656E7469666965723A6E756C6C2C7061';
wwv_flow_api.g_varchar2_table(2) := '67654974656D733A22222C74656D706C6174654E6F3A312C6E6F44617461466F756E644D6573736167653A22222C6E6F446174613A21317D2C674E6F44617461243A6E756C6C2C67526567696F6E243A6E756C6C2C67526567696F6E426F6479243A6E75';
wwv_flow_api.g_varchar2_table(3) := '6C6C2C5F6372656174653A66756E6374696F6E28297B76617220653D746869733B612E75692E636972636C6966756C47617567652E70726F746F747970652E67657449636F6E556E69636F64653D66756E6374696F6E2865297B76617220663D7B676C61';
wwv_flow_api.g_varchar2_table(4) := '73733A2266303030222C6D757369633A2266303031222C7365617263683A2266303032222C22656E76656C6F70652D6F223A2266303033222C68656172743A2266303034222C737461723A2266303035222C22737461722D6F223A2266303036222C7573';
wwv_flow_api.g_varchar2_table(5) := '65723A2266303037222C66696C6D3A2266303038222C2274682D6C61726765223A2266303039222C74683A2266303061222C2274682D6C697374223A2266303062222C636865636B3A2266303063222C72656D6F76653A2266303064222C636C6F73653A';
wwv_flow_api.g_varchar2_table(6) := '2266303064222C74696D65733A2266303064222C227365617263682D706C7573223A2266303065222C227365617263682D6D696E7573223A2266303130222C22706F7765722D6F6666223A2266303131222C7369676E616C3A2266303132222C67656172';
wwv_flow_api.g_varchar2_table(7) := '3A2266303133222C636F673A2266303133222C2274726173682D6F223A2266303134222C686F6D653A2266303135222C2266696C652D6F223A2266303136222C22636C6F636B2D6F223A2266303137222C726F61643A2266303138222C646F776E6C6F61';
wwv_flow_api.g_varchar2_table(8) := '643A2266303139222C226172726F772D636972636C652D6F2D646F776E223A2266303161222C226172726F772D636972636C652D6F2D7570223A2266303162222C696E626F783A2266303163222C22706C61792D636972636C652D6F223A226630316422';
wwv_flow_api.g_varchar2_table(9) := '2C22726F746174652D7269676874223A2266303165222C7265706561743A2266303165222C726566726573683A2266303231222C226C6973742D616C74223A2266303232222C6C6F636B3A2266303233222C666C61673A2266303234222C686561647068';
wwv_flow_api.g_varchar2_table(10) := '6F6E65733A2266303235222C22766F6C756D652D6F6666223A2266303236222C22766F6C756D652D646F776E223A2266303237222C22766F6C756D652D7570223A2266303238222C7172636F64653A2266303239222C626172636F64653A226630326122';
wwv_flow_api.g_varchar2_table(11) := '2C7461673A2266303262222C746167733A2266303263222C626F6F6B3A2266303264222C626F6F6B6D61726B3A2266303265222C7072696E743A2266303266222C63616D6572613A2266303330222C666F6E743A2266303331222C626F6C643A22663033';
wwv_flow_api.g_varchar2_table(12) := '32222C6974616C69633A2266303333222C22746578742D686569676874223A2266303334222C22746578742D7769647468223A2266303335222C22616C69676E2D6C656674223A2266303336222C22616C69676E2D63656E746572223A2266303337222C';
wwv_flow_api.g_varchar2_table(13) := '22616C69676E2D7269676874223A2266303338222C22616C69676E2D6A757374696679223A2266303339222C6C6973743A2266303361222C646564656E743A2266303362222C6F757464656E743A2266303362222C696E64656E743A2266303363222C22';
wwv_flow_api.g_varchar2_table(14) := '766964656F2D63616D657261223A2266303364222C70686F746F3A2266303365222C696D6167653A2266303365222C22706963747572652D6F223A2266303365222C70656E63696C3A2266303430222C226D61702D6D61726B6572223A2266303431222C';
wwv_flow_api.g_varchar2_table(15) := '61646A7573743A2266303432222C74696E743A2266303433222C656469743A2266303365222C2270656E63696C2D7371756172652D6F223A2266303434222C2273686172652D7371756172652D6F223A2266303435222C22636865636B2D737175617265';
wwv_flow_api.g_varchar2_table(16) := '2D6F223A2266303436222C6172726F77733A2266303437222C22737465702D6261636B77617264223A2266303438222C22666173742D6261636B77617264223A2266303439222C6261636B776172643A2266303461222C706C61793A2266303462222C70';
wwv_flow_api.g_varchar2_table(17) := '617573653A2266303463222C73746F703A2266303464222C666F72776172643A2266303465222C22666173742D666F7277617264223A2266303530222C22737465702D666F7277617264223A2266303531222C656A6563743A2266303532222C22636865';
wwv_flow_api.g_varchar2_table(18) := '76726F6E2D6C656674223A2266303533222C2263686576726F6E2D7269676874223A2266303534222C22706C75732D636972636C65223A2266303535222C226D696E75732D636972636C65223A2266303536222C2274696D65732D636972636C65223A22';
wwv_flow_api.g_varchar2_table(19) := '66303537222C22636865636B2D636972636C65223A2266303538222C227175657374696F6E2D636972636C65223A2266303539222C22696E666F2D636972636C65223A2266303561222C63726F737368616972733A2266303562222C2274696D65732D63';
wwv_flow_api.g_varchar2_table(20) := '6972636C652D6F223A2266303563222C22636865636B2D636972636C652D6F223A2266303564222C62616E3A2266303565222C226172726F772D6C656674223A2266303630222C226172726F772D7269676874223A2266303631222C226172726F772D75';
wwv_flow_api.g_varchar2_table(21) := '70223A2266303632222C226172726F772D646F776E223A2266303633222C226D61696C2D666F7277617264223A2266303634222C73686172653A2266303634222C657870616E643A2266303635222C636F6D70726573733A2266303636222C706C75733A';
wwv_flow_api.g_varchar2_table(22) := '2266303637222C6D696E75733A2266303638222C617374657269736B3A2266303639222C226578636C616D6174696F6E2D636972636C65223A2266303661222C676966743A2266303662222C6C6561663A2266303663222C666972653A2266303664222C';
wwv_flow_api.g_varchar2_table(23) := '6579653A2266303665222C226579652D736C617368223A2266303730222C7761726E696E673A2266303731222C226578636C616D6174696F6E2D747269616E676C65223A2266303731222C706C616E653A2266303732222C63616C656E6461723A226630';
wwv_flow_api.g_varchar2_table(24) := '3733222C72616E646F6D3A2266303734222C636F6D6D656E743A2266303735222C6D61676E65743A2266303736222C2263686576726F6E2D7570223A2266303737222C2263686576726F6E2D646F776E223A2266303738222C726574776565743A226630';
wwv_flow_api.g_varchar2_table(25) := '3739222C2273686F7070696E672D63617274223A2266303761222C666F6C6465723A2266303762222C22666F6C6465722D6F70656E223A2266303763222C226172726F77732D76223A2266303764222C226172726F77732D68223A2266303765222C2262';
wwv_flow_api.g_varchar2_table(26) := '61722D63686172742D6F223A2266303830222C226261722D6368617274223A2266303830222C22747769747465722D737175617265223A2266303831222C2266616365626F6F6B2D737175617265223A2266303832222C2263616D6572612D726574726F';
wwv_flow_api.g_varchar2_table(27) := '223A2266303833222C6B65793A2266303834222C67656172733A2266303835222C636F67733A2266303835222C636F6D6D656E74733A2266303836222C227468756D62732D6F2D7570223A2266303837222C227468756D62732D6F2D646F776E223A2266';
wwv_flow_api.g_varchar2_table(28) := '303838222C22737461722D68616C66223A2266303839222C2268656172742D6F223A2266303861222C227369676E2D6F7574223A2266303862222C226C696E6B6564696E2D737175617265223A2266303863222C227468756D622D7461636B223A226630';
wwv_flow_api.g_varchar2_table(29) := '3864222C2265787465726E616C2D6C696E6B223A2266303865222C227369676E2D696E223A2266303930222C74726F7068793A2266303931222C226769746875622D737175617265223A2266303932222C75706C6F61643A2266303933222C226C656D6F';
wwv_flow_api.g_varchar2_table(30) := '6E2D6F223A2266303934222C70686F6E653A2266303935222C227371756172652D6F223A2266303936222C22626F6F6B6D61726B2D6F223A2266303937222C2270686F6E652D737175617265223A2266303938222C747769747465723A2266303939222C';
wwv_flow_api.g_varchar2_table(31) := '66616365626F6F6B3A2266303961222C6769746875623A2266303962222C756E6C6F636B3A2266303963222C226372656469742D63617264223A2266303964222C7273733A2266303965222C226864642D6F223A2266306130222C62756C6C686F726E3A';
wwv_flow_api.g_varchar2_table(32) := '2266306131222C62656C6C3A2266306633222C63657274696669636174653A2266306133222C2268616E642D6F2D7269676874223A2266306134222C2268616E642D6F2D6C656674223A2266306135222C2268616E642D6F2D7570223A2266306136222C';
wwv_flow_api.g_varchar2_table(33) := '2268616E642D6F2D646F776E223A2266306137222C226172726F772D636972636C652D6C656674223A2266306138222C226172726F772D636972636C652D7269676874223A2266306139222C226172726F772D636972636C652D7570223A226630616122';
wwv_flow_api.g_varchar2_table(34) := '2C226172726F772D636972636C652D646F776E223A2266306162222C676C6F62653A2266306163222C7772656E63683A2266306164222C7461736B733A2266306165222C66696C7465723A2266306230222C6272696566636173653A2266306231222C22';
wwv_flow_api.g_varchar2_table(35) := '6172726F77732D616C74223A2266306232222C67726F75703A2266306330222C75736572733A2266306330222C636861696E3A2266306331222C6C696E6B3A2266306331222C636C6F75643A2266306332222C666C61736B3A2266306333222C6375743A';
wwv_flow_api.g_varchar2_table(36) := '2266306334222C73636973736F72733A2266306334222C636F70793A2266306335222C2266696C65732D6F223A2266306335222C7061706572636C69703A2266306336222C736176653A2266306337222C22666C6F7070792D6F223A2266306337222C73';
wwv_flow_api.g_varchar2_table(37) := '71756172653A2266306338222C6E617669636F6E3A2266306339222C72656F726465723A2266306339222C626172733A2266306339222C226C6973742D756C223A2266306361222C226C6973742D6F6C223A2266306362222C737472696B657468726F75';
wwv_flow_api.g_varchar2_table(38) := '67683A2266306363222C756E6465726C696E653A2266306364222C7461626C653A2266306365222C6D616769633A2266306430222C747275636B3A2266306431222C70696E7465726573743A2266306432222C2270696E7465726573742D737175617265';
wwv_flow_api.g_varchar2_table(39) := '223A2266306433222C22676F6F676C652D706C75732D737175617265223A2266306434222C22676F6F676C652D706C7573223A2266306435222C6D6F6E65793A2266306436222C2263617265742D646F776E223A2266306437222C2263617265742D7570';
wwv_flow_api.g_varchar2_table(40) := '223A2266306438222C2263617265742D6C656674223A2266306439222C2263617265742D7269676874223A2266306461222C636F6C756D6E733A2266306462222C756E736F727465643A2266306463222C736F72743A2266306463222C22736F72742D64';
wwv_flow_api.g_varchar2_table(41) := '6F776E223A2266306464222C22736F72742D64657363223A2266306464222C22736F72742D7570223A2266306465222C22736F72742D617363223A2266306465222C656E76656C6F70653A2266306530222C6C696E6B6564696E3A2266306531222C2272';
wwv_flow_api.g_varchar2_table(42) := '6F746174652D6C656674223A2266306532222C756E646F3A2266306532222C6C6567616C3A2266306533222C676176656C3A2266306533222C64617368626F6172643A2266306534222C746163686F6D657465723A2266306534222C22636F6D6D656E74';
wwv_flow_api.g_varchar2_table(43) := '2D6F223A2266306535222C22636F6D6D656E74732D6F223A2266306536222C666C6173683A2266306537222C626F6C743A2266306537222C736974656D61703A2266306538222C756D6272656C6C613A2266306539222C70617374653A2266306561222C';
wwv_flow_api.g_varchar2_table(44) := '636C6970626F6172643A2266306561222C226C6967687462756C622D6F223A2266306562222C65786368616E67653A2266306563222C22636C6F75642D646F776E6C6F6164223A2266306564222C22636C6F75642D75706C6F6164223A2266306565222C';
wwv_flow_api.g_varchar2_table(45) := '22757365722D6D64223A2266306630222C73746574686F73636F70653A2266306631222C73756974636173653A2266306632222C2262656C6C2D6F223A2266306132222C636F666665653A2266306634222C6375746C6572793A2266306635222C226669';
wwv_flow_api.g_varchar2_table(46) := '6C652D746578742D6F223A2266306636222C226275696C64696E672D6F223A2266306637222C22686F73706974616C2D6F223A2266306638222C616D62756C616E63653A2266306639222C6D65646B69743A2266306661222C22666967687465722D6A65';
wwv_flow_api.g_varchar2_table(47) := '74223A2266306662222C626565723A2266306663222C22682D737175617265223A2266306664222C22706C75732D737175617265223A2266306665222C22616E676C652D646F75626C652D6C656674223A2266313030222C22616E676C652D646F75626C';
wwv_flow_api.g_varchar2_table(48) := '652D7269676874223A2266313031222C22616E676C652D646F75626C652D7570223A2266313032222C22616E676C652D646F75626C652D646F776E223A2266313033222C22616E676C652D6C656674223A2266313034222C22616E676C652D7269676874';
wwv_flow_api.g_varchar2_table(49) := '223A2266313035222C22616E676C652D7570223A2266313036222C22616E676C652D646F776E223A2266313037222C6465736B746F703A2266313038222C6C6170746F703A2266313039222C7461626C65743A2266313061222C226D6F62696C652D7068';
wwv_flow_api.g_varchar2_table(50) := '6F6E65223A2266313062222C6D6F62696C653A2266313062222C22636972636C652D6F223A2266313063222C2271756F74652D6C656674223A2266313064222C2271756F74652D7269676874223A2266313065222C7370696E6E65723A2266313130222C';
wwv_flow_api.g_varchar2_table(51) := '636972636C653A2266313131222C226D61696C2D7265706C79223A2266313132222C7265706C793A2266313132222C226769746875622D616C74223A2266313133222C22666F6C6465722D6F223A2266313134222C22666F6C6465722D6F70656E2D6F22';
wwv_flow_api.g_varchar2_table(52) := '3A2266313135222C22736D696C652D6F223A2266313138222C2266726F776E2D6F223A2266313139222C226D65682D6F223A2266313161222C67616D657061643A2266313162222C226B6579626F6172642D6F223A2266313163222C22666C61672D6F22';
wwv_flow_api.g_varchar2_table(53) := '3A2266313164222C22666C61672D636865636B65726564223A2266313165222C7465726D696E616C3A2266313230222C636F64653A2266313231222C226D61696C2D7265706C792D616C6C223A2266313232222C227265706C792D616C6C223A22663132';
wwv_flow_api.g_varchar2_table(54) := '32222C22737461722D68616C662D656D707479223A2266313233222C22737461722D68616C662D66756C6C223A2266313233222C22737461722D68616C662D6F223A2266313233222C226C6F636174696F6E2D6172726F77223A2266313234222C63726F';
wwv_flow_api.g_varchar2_table(55) := '703A2266313235222C22636F64652D666F726B223A2266313236222C756E6C696E6B3A2266313237222C22636861696E2D62726F6B656E223A2266313237222C7175657374696F6E3A2266313238222C696E666F3A2266313239222C6578636C616D6174';
wwv_flow_api.g_varchar2_table(56) := '696F6E3A2266313261222C73757065727363726970743A2266313262222C7375627363726970743A2266313263222C6572617365723A2266313264222C2270757A7A6C652D7069656365223A2266313265222C6D6963726F70686F6E653A226631333022';
wwv_flow_api.g_varchar2_table(57) := '2C226D6963726F70686F6E652D736C617368223A2266313331222C736869656C643A2266313332222C2263616C656E6461722D6F223A2266313333222C22666972652D657874696E67756973686572223A2266313334222C726F636B65743A2266313335';
wwv_flow_api.g_varchar2_table(58) := '222C6D617863646E3A2266313336222C2263686576726F6E2D636972636C652D6C656674223A2266313337222C2263686576726F6E2D636972636C652D7269676874223A2266313338222C2263686576726F6E2D636972636C652D7570223A2266313339';
wwv_flow_api.g_varchar2_table(59) := '222C2263686576726F6E2D636972636C652D646F776E223A2266313361222C68746D6C353A2266313362222C637373333A2266313363222C616E63686F723A2266313364222C22756E6C6F636B2D616C74223A2266313365222C62756C6C736579653A22';
wwv_flow_api.g_varchar2_table(60) := '66313430222C22656C6C69707369732D68223A2266313431222C22656C6C69707369732D76223A2266313432222C227273732D737175617265223A2266313433222C22706C61792D636972636C65223A2266313434222C7469636B65743A226631343522';
wwv_flow_api.g_varchar2_table(61) := '2C226D696E75732D737175617265223A2266313436222C226D696E75732D7371756172652D6F223A2266313437222C226C6576656C2D7570223A2266313438222C226C6576656C2D646F776E223A2266313439222C22636865636B2D737175617265223A';
wwv_flow_api.g_varchar2_table(62) := '2266313461222C2270656E63696C2D737175617265223A2266313462222C2265787465726E616C2D6C696E6B2D737175617265223A2266313463222C2273686172652D737175617265223A2266313464222C636F6D706173733A2266313465222C22746F';
wwv_flow_api.g_varchar2_table(63) := '67676C652D646F776E223A2266313530222C2263617265742D7371756172652D6F2D646F776E223A2266313530222C22746F67676C652D7570223A2266313531222C2263617265742D7371756172652D6F2D7570223A2266313531222C22746F67676C65';
wwv_flow_api.g_varchar2_table(64) := '2D7269676874223A2266313532222C2263617265742D7371756172652D6F2D7269676874223A2266313532222C6575726F3A2266313533222C6575723A2266313533222C6762703A2266313534222C646F6C6C61723A2266313535222C7573643A226631';
wwv_flow_api.g_varchar2_table(65) := '3535222C72757065653A2266313536222C696E723A2266313536222C636E793A2266313537222C726D623A2266313537222C79656E3A2266313537222C6A70793A2266313537222C7275626C653A2266313538222C726F75626C653A2266313538222C72';
wwv_flow_api.g_varchar2_table(66) := '75623A2266313538222C776F6E3A2266313539222C6B72773A2266313539222C626974636F696E3A2266313561222C6274633A2266313561222C66696C653A2266313562222C2266696C652D74657874223A2266313563222C22736F72742D616C706861';
wwv_flow_api.g_varchar2_table(67) := '2D617363223A2266313564222C22736F72742D616C7068612D64657363223A2266313565222C22736F72742D616D6F756E742D617363223A2266313630222C22736F72742D616D6F756E742D64657363223A2266313631222C22736F72742D6E756D6572';
wwv_flow_api.g_varchar2_table(68) := '69632D617363223A2266313632222C22736F72742D6E756D657269632D64657363223A2266313633222C227468756D62732D7570223A2266313634222C227468756D62732D646F776E223A2266313635222C22796F75747562652D737175617265223A22';
wwv_flow_api.g_varchar2_table(69) := '66313636222C796F75747562653A2266313637222C78696E673A2266313638222C2278696E672D737175617265223A2266313639222C22796F75747562652D706C6179223A2266313661222C64726F70626F783A2266313662222C22737461636B2D6F76';
wwv_flow_api.g_varchar2_table(70) := '6572666C6F77223A2266313663222C696E7374616772616D3A2266313664222C666C69636B723A2266313665222C61646E3A2266313730222C6269746275636B65743A2266313731222C226269746275636B65742D737175617265223A2266313732222C';
wwv_flow_api.g_varchar2_table(71) := '74756D626C723A2266313733222C2274756D626C722D737175617265223A2266313734222C226C6F6E672D6172726F772D646F776E223A2266313735222C226C6F6E672D6172726F772D7570223A2266313736222C226C6F6E672D6172726F772D6C6566';
wwv_flow_api.g_varchar2_table(72) := '74223A2266313737222C226C6F6E672D6172726F772D7269676874223A2266313738222C6170706C653A2266313739222C77696E646F77733A2266313761222C616E64726F69643A2266313762222C6C696E75783A2266313763222C6472696262626C65';
wwv_flow_api.g_varchar2_table(73) := '3A2266313764222C736B7970653A2266313765222C666F75727371756172653A2266313830222C7472656C6C6F3A2266313831222C66656D616C653A2266313832222C6D616C653A2266313833222C6769747469703A2266313834222C2273756E2D6F22';
wwv_flow_api.g_varchar2_table(74) := '3A2266313835222C226D6F6F6E2D6F223A2266313836222C617263686976653A2266313837222C6275673A2266313838222C766B3A2266313839222C776569626F3A2266313861222C72656E72656E3A2266313862222C706167656C696E65733A226631';
wwv_flow_api.g_varchar2_table(75) := '3863222C22737461636B2D65786368616E6765223A2266313864222C226172726F772D636972636C652D6F2D7269676874223A2266313865222C226172726F772D636972636C652D6F2D6C656674223A2266313930222C22746F67676C652D6C65667422';
wwv_flow_api.g_varchar2_table(76) := '3A2266313931222C2263617265742D7371756172652D6F2D6C656674223A2266313931222C22646F742D636972636C652D6F223A2266313932222C776865656C63686169723A2266313933222C2276696D656F2D737175617265223A2266313934222C22';
wwv_flow_api.g_varchar2_table(77) := '7475726B6973682D6C697261223A2266313935222C22747279223A2266313935222C22706C75732D7371756172652D6F223A2266313936222C2273706163652D73687574746C65223A2266313937222C736C61636B3A2266313938222C22656E76656C6F';
wwv_flow_api.g_varchar2_table(78) := '70652D737175617265223A2266313939222C776F726470726573733A2266313961222C6F70656E69643A2266313962222C696E737469747574696F6E3A2266313963222C62616E6B3A2266313963222C756E69766572736974793A2266313963222C226D';
wwv_flow_api.g_varchar2_table(79) := '6F727461722D626F617264223A2266313964222C2267726164756174696F6E2D636170223A2266313964222C7961686F6F3A2266313965222C676F6F676C653A2266316130222C7265646469743A2266316131222C227265646469742D73717561726522';
wwv_flow_api.g_varchar2_table(80) := '3A2266316132222C227374756D626C6575706F6E2D636972636C65223A2266316133222C7374756D626C6575706F6E3A2266316134222C64656C6963696F75733A2266316135222C646967673A2266316136222C22706965642D7069706572223A226631';
wwv_flow_api.g_varchar2_table(81) := '6137222C22706965642D70697065722D616C74223A2266316138222C64727570616C3A2266316139222C6A6F6F6D6C613A2266316161222C6C616E67756167653A2266316162222C6661783A2266316163222C6275696C64696E673A2266316164222C63';
wwv_flow_api.g_varchar2_table(82) := '68696C643A2266316165222C7061773A2266316230222C73706F6F6E3A2266316231222C637562653A2266316232222C63756265733A2266316233222C626568616E63653A2266316234222C22626568616E63652D737175617265223A2266316235222C';
wwv_flow_api.g_varchar2_table(83) := '737465616D3A2266316236222C22737465616D2D737175617265223A2266316237222C72656379636C653A2266316238222C6175746F6D6F62696C653A2266316239222C6361723A2266316239222C6361623A2266316261222C746178693A2266316261';
wwv_flow_api.g_varchar2_table(84) := '222C747265653A2266316262222C73706F746966793A2266316263222C64657669616E746172743A2266316264222C736F756E64636C6F75643A2266316265222C64617461626173653A2266316330222C2266696C652D7064662D6F223A226631633122';
wwv_flow_api.g_varchar2_table(85) := '2C2266696C652D776F72642D6F223A2266316332222C2266696C652D657863656C2D6F223A2266316333222C2266696C652D706F776572706F696E742D6F223A2266316334222C2266696C652D70686F746F2D6F223A2266316335222C2266696C652D70';
wwv_flow_api.g_varchar2_table(86) := '6963747572652D6F223A2266316335222C2266696C652D696D6167652D6F223A2266316335222C2266696C652D7A69702D6F223A2266316336222C2266696C652D617263686976652D6F223A2266316336222C2266696C652D736F756E642D6F223A2266';
wwv_flow_api.g_varchar2_table(87) := '316337222C2266696C652D617564696F2D6F223A2266316337222C2266696C652D6D6F7669652D6F223A2266316338222C2266696C652D766964656F2D6F223A2266316338222C2266696C652D636F64652D6F223A2266316339222C76696E653A226631';
wwv_flow_api.g_varchar2_table(88) := '6361222C636F646570656E3A2266316362222C6A73666964646C653A2266316363222C226C6966652D626F7579223A2266316364222C226C6966652D62756F79223A2266316364222C226C6966652D7361766572223A2266316364222C737570706F7274';
wwv_flow_api.g_varchar2_table(89) := '3A2266316364222C226C6966652D72696E67223A2266316364222C22636972636C652D6F2D6E6F746368223A2266316365222C72613A2266316430222C726562656C3A2266316430222C67653A2266316431222C656D706972653A2266316431222C2267';
wwv_flow_api.g_varchar2_table(90) := '69742D737175617265223A2266316432222C6769743A2266316433222C226861636B65722D6E657773223A2266316434222C2274656E63656E742D776569626F223A2266316435222C71713A2266316436222C7765636861743A2266316437222C776569';
wwv_flow_api.g_varchar2_table(91) := '78696E3A2266316437222C73656E643A2266316438222C2270617065722D706C616E65223A2266316438222C2273656E642D6F223A2266316439222C2270617065722D706C616E652D6F223A2266316439222C686973746F72793A2266316461222C2263';
wwv_flow_api.g_varchar2_table(92) := '6972636C652D7468696E223A2266316462222C6865616465723A2266316463222C7061726167726170683A2266316464222C736C69646572733A2266316465222C2273686172652D616C74223A2266316530222C2273686172652D616C742D7371756172';
wwv_flow_api.g_varchar2_table(93) := '65223A2266316531222C626F6D623A2266316532222C22736F636365722D62616C6C2D6F223A2266316533222C22667574626F6C2D6F223A2266316533222C7474793A2266316534222C62696E6F63756C6172733A2266316535222C706C75673A226631';
wwv_flow_api.g_varchar2_table(94) := '6536222C736C69646573686172653A2266316537222C7477697463683A2266316538222C79656C703A2266316539222C226E65777370617065722D6F223A2266316561222C776966693A2266316562222C63616C63756C61746F723A2266316563222C70';
wwv_flow_api.g_varchar2_table(95) := '617970616C3A2266316564222C22676F6F676C652D77616C6C6574223A2266316565222C2263632D76697361223A2266316630222C2263632D6D617374657263617264223A2266316631222C2263632D646973636F766572223A2266316632222C226363';
wwv_flow_api.g_varchar2_table(96) := '2D616D6578223A2266316633222C2263632D70617970616C223A2266316634222C2263632D737472697065223A2266316635222C2262656C6C2D736C617368223A2266316636222C2262656C6C2D736C6173682D6F223A2266316637222C74726173683A';
wwv_flow_api.g_varchar2_table(97) := '2266316638222C636F707972696768743A2266316639222C61743A2266316661222C65796564726F707065723A2266316662222C227061696E742D6272757368223A2266316663222C2262697274686461792D63616B65223A2266316664222C22617265';
wwv_flow_api.g_varchar2_table(98) := '612D6368617274223A2266316665222C227069652D6368617274223A2266323030222C226C696E652D6368617274223A2266323031222C6C617374666D3A2266323032222C226C617374666D2D737175617265223A2266323033222C22746F67676C652D';
wwv_flow_api.g_varchar2_table(99) := '6F6666223A2266323034222C22746F67676C652D6F6E223A2266323035222C62696379636C653A2266323036222C6275733A2266323037222C696F78686F73743A2266323038222C616E67656C6C6973743A2266323039222C63633A2266323061222C73';
wwv_flow_api.g_varchar2_table(100) := '68656B656C3A2266323062222C73686571656C3A2266323062222C696C733A2266323062222C6D65616E706174683A2266323063227D3B72657475726E20665B652E737562737472696E6728332C652E6C656E677468295D7D2C652E67526567696F6E24';
wwv_flow_api.g_varchar2_table(101) := '3D61282223222B652E656C656D656E742E617474722822696422292C617065782E6750616765436F6E7465787424292C746869732E5F6275696C6454656D706C61746528292C652E67526567696F6E242E6F6E28226170657872656672657368222C652E';
wwv_flow_api.g_varchar2_table(102) := '5F726566726573682E62696E64286529292E747269676765722822617065787265667265736822297D2C5F696E69743A66756E6374696F6E28297B7D2C5F6275696C6454656D706C6174653A66756E6374696F6E28297B76617220663D746869733B6966';
wwv_flow_api.g_varchar2_table(103) := '28662E67526567696F6E243D61282223222B662E656C656D656E742E617474722822696422292C617065782E6750616765436F6E7465787424292C662E67526567696F6E426F6479243D662E67526567696F6E242E66696E6428222E742D526567696F6E';
wwv_flow_api.g_varchar2_table(104) := '2D626F647922292C303D3D3D662E67526567696F6E426F6479242E6C656E677468297B766172206F3D652E68746D6C4275696C64657228293B6F2E6D61726B757028273C64697620636C6173733D22742D526567696F6E2D626F647957726170223E3C64';
wwv_flow_api.g_varchar2_table(105) := '697620636C6173733D22742D526567696F6E2D626F647920636972636C69436F6E7461696E6572223E3C2F6469763E3C2F6469763E27292C662E67526567696F6E426F6479243D662E67526567696F6E242E617070656E64286F2E746F537472696E6728';
wwv_flow_api.g_varchar2_table(106) := '29292E66696E6428222E742D526567696F6E2D626F647922297D656C736520662E67526567696F6E426F6479242E616464436C6173732822636972636C69436F6E7461696E657222293B76617220723D652E68746D6C4275696C64657228293B722E6D61';
wwv_flow_api.g_varchar2_table(107) := '726B757028273C64697620636C6173733D22612D436972636C6947617567652D6D65737361676520612D436972636C6947617567652D6E6F44617461466F756E642D636F6E7461696E6572223E27292E6D61726B757028273C64697620636C6173733D22';
wwv_flow_api.g_varchar2_table(108) := '612D436972636C6947617567652D6D65737361676549636F6E2020612D436972636C6947617567652D6E6F44617461466F756E64223E27292E6D61726B757028273C7370616E20636C6173733D22612D49636F6E2069636F6E2D6972722D68656C70223E';
wwv_flow_api.g_varchar2_table(109) := '3C2F7370616E3E3C2F6469763E27292E6D61726B757028273C7370616E20636C6173733D22612D436972636C6947617567652D6D65737361676554657874223E234D5347233C2F7370616E3E3C2F6469763E27292C662E674E6F44617461243D6128722E';
wwv_flow_api.g_varchar2_table(110) := '746F537472696E6728292E7265706C6163652822234D534723222C662E6F7074696F6E732E6E6F44617461466F756E644D65737361676529292E6869646528292C662E67526567696F6E426F6479242E616674657228662E674E6F4461746124297D2C5F';
wwv_flow_api.g_varchar2_table(111) := '647261773A66756E6374696F6E2866297B76617220723D746869733B674F7074696F6E733D722E6F7074696F6E732C612E657874656E6428746869732E6F7074696F6E732C66293B666F722876617220743D302C693D746869732E6F7074696F6E732E63';
wwv_flow_api.g_varchar2_table(112) := '686172742E6C656E6774683B693E743B742B2B297B76617220632C6C3D28652E68746D6C4275696C64657228292C722E656C656D656E742E617474722822696422292B225F636972636C695F222B28742B3129292C6E3D652E68746D6C4275696C646572';
wwv_flow_api.g_varchar2_table(113) := '28293B6E2E6D61726B757028273C64697620636C6173733D22636F6C20636F6C2D23434F4C5F5350414E23223E27292C323D3D722E6F7074696F6E732E74656D706C6174654E6F3F6E2E6D61726B757028273C64697620636C6173733D22742D52656769';
wwv_flow_api.g_varchar2_table(114) := '6F6E20742D526567696F6E2D2D7363726F6C6C426F647920742D526567696F6E2D626F6479577261702220726F6C653D2267726F75702220617269612D6C6162656C6C656462793D22272B722E656C656D656E742E617474722822696422292B275F6368';
wwv_flow_api.g_varchar2_table(115) := '6172745F68656164696E67223E3C64697620636C6173733D22742D526567696F6E2D626F6479223E27293A333D3D722E6F7074696F6E732E74656D706C6174654E6F26266E2E6D61726B757028273C64697620636C6173733D22742D526567696F6E2074';
wwv_flow_api.g_varchar2_table(116) := '2D526567696F6E2D2D7363726F6C6C426F64792220726F6C653D2267726F75702220617269612D6C6162656C6C656462793D22272B722E656C656D656E742E617474722822696422292B275F63686172745F68656164696E67223E27292E6D61726B7570';
wwv_flow_api.g_varchar2_table(117) := '28273C64697620636C6173733D22742D526567696F6E2D686561646572223E3C64697620636C6173733D22742D526567696F6E2D6865616465724974656D7320742D526567696F6E2D6865616465724974656D732D2D7469746C65223E3C683220636C61';
wwv_flow_api.g_varchar2_table(118) := '73733D22742D526567696F6E2D7469746C65222069643D22272B722E656C656D656E742E617474722822696422292B275F63686172745F68656164696E67223E235245475F5449544C45233C2F68323E3C2F6469763E27292E6D61726B757028273C2F64';
wwv_flow_api.g_varchar2_table(119) := '69763E3C64697620636C6173733D22742D526567696F6E2D626F647957726170223E3C64697620636C6173733D22742D526567696F6E2D626F6479223E27292C6E2E6D61726B757028273C7370616E206964203D2022272B6C2B27223E3C2F7370616E3E';
wwv_flow_api.g_varchar2_table(120) := '27292C313D3D722E6F7074696F6E732E74656D706C6174654E6F3F6E2E6D61726B757028223C2F6469763E22293A323D3D722E6F7074696F6E732E74656D706C6174654E6F3F6E2E6D61726B757028223C2F6469763E3C2F6469763E22293A6E2E6D6172';
wwv_flow_api.g_varchar2_table(121) := '6B757028223C2F6469763E3C2F6469763E3C2F6469763E3C2F6469763E22292C633D6E2E746F537472696E6728292E7265706C616365282223434F4C5F5350414E23222C722E6F7074696F6E732E63686172745B745D2E636F6C5370616E292C633D333D';
wwv_flow_api.g_varchar2_table(122) := '3D722E6F7074696F6E732E74656D706C6174654E6F3F632E7265706C6163652822235245475F5449544C4523222C722E6F7074696F6E732E63686172745B745D2E74657874293A632E7265706C6163652822235245475F5449544C4523222C2222292C33';
wwv_flow_api.g_varchar2_table(123) := '3D3D722E6F7074696F6E732E74656D706C6174654E6F262628722E6F7074696F6E732E63686172745B745D2E746578743D6E756C6C2C722E6F7074696F6E732E63686172745B745D2E7465787442656C6F773D2131292C722E67526567696F6E426F6479';
wwv_flow_api.g_varchar2_table(124) := '242E617070656E642863292C22223D3D3D746869732E6F7074696F6E732E63686172745B745D2E69636F6E464126266E756C6C3D3D3D746869732E6F7074696F6E732E63686172745B745D2E69636F6E46417C7C746869732E6F7074696F6E732E636861';
wwv_flow_api.g_varchar2_table(125) := '72745B745D2E69636F6E46413D3D6F7C7C28746869732E6F7074696F6E732E63686172745B745D2E69636F6E3D722E67657449636F6E556E69636F646528746869732E6F7074696F6E732E63686172745B745D2E69636F6E464129292C61282223222B6C';
wwv_flow_api.g_varchar2_table(126) := '292E636972636C6966756C28746869732E6F7074696F6E732E63686172745B745D297D7D2C5F64656275673A66756E6374696F6E2865297B617065782E64656275672E6C6F672865297D2C5F636C6561723A66756E6374696F6E28297B7D2C5F72656672';
wwv_flow_api.g_varchar2_table(127) := '6573683A66756E6374696F6E28297B76617220652C663D746869733B617065782E7365727665722E706C7567696E28662E6F7074696F6E732E616A61784964656E7469666965722C7B706167654974656D733A662E6F7074696F6E732E70616765497465';
wwv_flow_api.g_varchar2_table(128) := '6D737D2C7B64617461547970653A226A736F6E222C6163636570743A226170706C69636174696F6E2F6A736F6E222C6265666F726553656E643A66756E6374696F6E28297B653D617065782E7574696C2E73686F775370696E6E657228662E6752656769';
wwv_flow_api.g_varchar2_table(129) := '6F6E24297D2C737563636573733A66756E6374696F6E2865297B652E63686172742E6C656E6774683E3D313F28662E674E6F44617461242E6869646528292C662E67526567696F6E426F6479242E73686F7728292C662E67526567696F6E426F6479242E';
wwv_flow_api.g_varchar2_table(130) := '68746D6C282222292C662E5F64726177286529293A28662E67526567696F6E426F6479242E6869646528292C662E674E6F44617461242E73686F772829297D2C636F6D706C6574653A66756E6374696F6E28297B652E72656D6F766528297D2C6572726F';
wwv_flow_api.g_varchar2_table(131) := '723A662E5F64656275672C636C6561723A662E5F636C6561727D297D2C5F6372656174655461673A66756E6374696F6E2865297B72657475726E206128646F63756D656E742E637265617465456C656D656E74286529297D7D297D28617065782E757469';
wwv_flow_api.g_varchar2_table(132) := '6C2C617065782E7365727665722C617065782E6A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(8155969592364144)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_file_name=>'js/circlifulGauge.min.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2275736520737472696374223B2166756E6374696F6E2861297B612E666E2E636972636C6966756C3D66756E6374696F6E28622C63297B76617220643D612E657874656E64287B666F726567726F756E64436F6C6F723A2223333439384442222C626163';
wwv_flow_api.g_varchar2_table(2) := '6B67726F756E64436F6C6F723A2223636363222C706F696E74436F6C6F723A226E6F6E65222C66696C6C436F6C6F723A226E6F6E65222C666F726567726F756E64426F7264657257696474683A31352C6261636B67726F756E64426F7264657257696474';
wwv_flow_api.g_varchar2_table(3) := '683A31352C706F696E7453697A653A32382E352C666F6E74436F6C6F723A2223616161222C70657263656E743A37352C616E696D6174696F6E3A312C616E696D6174696F6E537465703A352C69636F6E3A226E6F6E65222C69636F6E53697A653A223330';
wwv_flow_api.g_varchar2_table(4) := '222C69636F6E436F6C6F723A2223636363222C69636F6E506F736974696F6E3A22746F70222C7461726765743A302C73746172743A302C73686F7750657263656E743A312C70657263656E746167655465787453697A653A32322C70657263656E746167';
wwv_flow_api.g_varchar2_table(5) := '65583A3130302C70657263656E74616765593A3130302C746578744164646974696F6E616C4373733A22222C74617267657450657263656E743A302C7461726765745465787453697A653A31372C746172676574436F6C6F723A2223323938304239222C';
wwv_flow_api.g_varchar2_table(6) := '746578743A6E756C6C2C746578745374796C653A6E756C6C2C74657874436F6C6F723A2223363636222C74657874593A6E756C6C2C74657874583A6E756C6C2C6D756C746950657263656E746167653A302C70657263656E74616765733A6E756C6C2C74';
wwv_flow_api.g_varchar2_table(7) := '65787442656C6F773A21312C6E6F50657263656E746167655369676E3A21312C7265706C61636550657263656E746167654279546578743A6E756C6C2C68616C66436972636C653A21312C616E696D617465496E566965773A21312C646563696D616C73';
wwv_flow_api.g_varchar2_table(8) := '3A302C616C77617973446563696D616C733A21312C7469746C653A22436972636C65204368617274222C6465736372697074696F6E3A22227D2C62293B72657475726E20746869732E656163682866756E6374696F6E28297B66756E6374696F6E207928';
wwv_flow_api.g_varchar2_table(9) := '297B76617220613D77696E646F772E736574496E74657276616C2866756E6374696F6E28297B723E3D783F2877696E646F772E636C656172496E74657276616C2861292C743D312C2266756E6374696F6E223D3D747970656F6620632626632E63616C6C';
wwv_flow_api.g_varchar2_table(10) := '287468697329293A28722B3D732C752B3D76292C722F332E363E3D652626313D3D74262628723D332E362A65292C753E642E7461726765742626313D3D74262628753D642E746172676574292C6E756C6C3D3D642E7265706C61636550657263656E7461';
wwv_flow_api.g_varchar2_table(11) := '6765427954657874262628773D642E68616C66436972636C653F7061727365466C6F6174283130302A722F3336302A32293A7061727365466C6F6174283130302A722F333630292C773D772E746F466978656428642E646563696D616C73292C21642E61';
wwv_flow_api.g_varchar2_table(12) := '6C77617973446563696D616C73262628303D3D657C7C653E31262631213D7429262628773D7061727365496E7428772929292C6F2E6174747228227374726F6B652D646173686172726179222C722B222C20323030303022292C313D3D642E73686F7750';
wwv_flow_api.g_varchar2_table(13) := '657263656E743F702E66696E6428222E6E756D62657222292E746578742877293A28702E66696E6428222E6E756D62657222292E746578742875292C702E66696E6428222E70657263656E7422292E7465787428222229297D2E62696E64286F292C7129';
wwv_flow_api.g_varchar2_table(14) := '7D66756E6374696F6E207A28297B76617220623D6E6176696761746F722E757365724167656E742E746F4C6F7765724361736528292E696E6465784F6628227765626B69742229213D2D313F22626F6479223A2268746D6C222C633D612862292E736372';
wwv_flow_api.g_varchar2_table(15) := '6F6C6C546F7028292C643D632B612877696E646F77292E68656967687428292C653D4D6174682E726F756E64286F2E6F666673657428292E746F70292C663D652B6F2E68656967687428293B72657475726E20653C642626663E637D66756E6374696F6E';
wwv_flow_api.g_varchar2_table(16) := '204128297B6F2E686173436C6173732822737461727422297C7C7A286F292626286F2E616464436C6173732822737461727422292C73657454696D656F757428792C32353029297D66756E6374696F6E204228622C63297B612E6561636828622C66756E';
wwv_flow_api.g_varchar2_table(17) := '6374696F6E28612C64297B612E746F4C6F776572436173652829696E2063262628625B615D3D635B612E746F4C6F7765724361736528295D297D297D76617220623D612874686973293B4228642C622E646174612829293B766172206A2C6B2C6C2C653D';
wwv_flow_api.g_varchar2_table(18) := '642E70657263656E742C663D38332C673D3130302C683D642E70657263656E74616765592C693D642E70657263656E74616765582C6D3D642E6261636B67726F756E64426F7264657257696474683B696628642E68616C66436972636C653F226C656674';
wwv_flow_api.g_varchar2_table(19) := '223D3D642E69636F6E506F736974696F6E3F28673D38302C663D3130302C693D3131372C683D313030293A642E68616C66436972636C65262628663D38302C683D313030293A22626F74746F6D223D3D642E69636F6E506F736974696F6E3F28663D3132';
wwv_flow_api.g_varchar2_table(20) := '342C683D3935293A226C656674223D3D642E69636F6E506F736974696F6E3F28673D38302C663D3131302C693D313137293A226D6964646C65223D3D642E69636F6E506F736974696F6E3F313D3D642E6D756C746950657263656E746167653F226F626A';
wwv_flow_api.g_varchar2_table(21) := '656374223D3D747970656F6620642E70657263656E74616765733F6D3D33303A28663D3131302C6B3D273C67207374726F6B653D22272B28226E6F6E6522213D642E6261636B67726F756E64436F6C6F723F642E6261636B67726F756E64436F6C6F723A';
wwv_flow_api.g_varchar2_table(22) := '222363636322292B2722203E3C6C696E652078313D22313333222079313D223530222078323D22313430222079323D22343022207374726F6B652D77696474683D22322220202F3E3C2F673E272C6B2B3D273C67207374726F6B653D22272B28226E6F6E';
wwv_flow_api.g_varchar2_table(23) := '6522213D642E6261636B67726F756E64436F6C6F723F642E6261636B67726F756E64436F6C6F723A222363636322292B2722203E3C6C696E652078313D22313430222079313D223430222078323D22323030222079323D22343022207374726F6B652D77';
wwv_flow_api.g_varchar2_table(24) := '696474683D22322220202F3E3C2F673E272C693D3232382C683D3437293A28663D3131302C6B3D273C67207374726F6B653D22272B28226E6F6E6522213D642E6261636B67726F756E64436F6C6F723F642E6261636B67726F756E64436F6C6F723A2223';
wwv_flow_api.g_varchar2_table(25) := '63636322292B2722203E3C6C696E652078313D22313333222079313D223530222078323D22313430222079323D22343022207374726F6B652D77696474683D22322220202F3E3C2F673E272C6B2B3D273C67207374726F6B653D22272B28226E6F6E6522';
wwv_flow_api.g_varchar2_table(26) := '213D642E6261636B67726F756E64436F6C6F723F642E6261636B67726F756E64436F6C6F723A222363636322292B2722203E3C6C696E652078313D22313430222079313D223430222078323D22323030222079323D22343022207374726F6B652D776964';
wwv_flow_api.g_varchar2_table(27) := '74683D22322220202F3E3C2F673E272C693D3137302C683D3335293A227269676874223D3D642E69636F6E506F736974696F6E262628673D3132302C663D3131302C693D3830292C642E74617267657450657263656E743E30262628683D39352C6B3D27';
wwv_flow_api.g_varchar2_table(28) := '3C67207374726F6B653D22272B28226E6F6E6522213D642E6261636B67726F756E64436F6C6F723F642E6261636B67726F756E64436F6C6F723A222363636322292B2722203E3C6C696E652078313D223735222079313D22313031222078323D22313235';
wwv_flow_api.g_varchar2_table(29) := '222079323D2231303122207374726F6B652D77696474683D22312220202F3E3C2F673E272C6B2B3D273C7465787420746578742D616E63686F723D226D6964646C652220783D22272B692B272220793D2231323022207374796C653D22666F6E742D7369';
wwv_flow_api.g_varchar2_table(30) := '7A653A20272B642E7461726765745465787453697A652B2770783B222066696C6C3D22272B642E746172676574436F6C6F722B27223E272B642E74617267657450657263656E742B28642E6E6F50657263656E746167655369676E26266E756C6C3D3D64';
wwv_flow_api.g_varchar2_table(31) := '2E7265706C61636550657263656E746167654279546578743F22223A222522292B223C2F746578743E222C6B2B3D273C636972636C652063783D22313030222063793D223130302220723D223639222066696C6C3D226E6F6E6522207374726F6B653D22';
wwv_flow_api.g_varchar2_table(32) := '272B642E6261636B67726F756E64436F6C6F722B2722207374726F6B652D77696474683D223322207374726F6B652D6461736861727261793D2234353022207472616E73666F726D3D22726F74617465282D39302C3130302C3130302922202F3E272C6B';
wwv_flow_api.g_varchar2_table(33) := '2B3D273C636972636C652063783D22313030222063793D223130302220723D223639222066696C6C3D226E6F6E6522207374726F6B653D22272B642E746172676574436F6C6F722B2722207374726F6B652D77696474683D223322207374726F6B652D64';
wwv_flow_api.g_varchar2_table(34) := '61736861727261793D22272B332E362A642E74617267657450657263656E742B272C20323030303022207472616E73666F726D3D22726F74617465282D39302C3130302C3130302922202F3E27292C6E756C6C213D642E74657874262628642E68616C66';
wwv_flow_api.g_varchar2_table(35) := '436972636C653F642E7465787442656C6F773F6B2B3D273C7465787420746578742D616E63686F723D226D6964646C652220783D22272B286E756C6C213D642E74657874583F642E74657874583A2231303022292B272220793D22272B286E756C6C213D';
wwv_flow_api.g_varchar2_table(36) := '642E74657874593F642E74657874593A2231323022292B2722207374796C653D22272B642E746578745374796C652B27222066696C6C3D22272B642E74657874436F6C6F722B27223E272B642E746578742B223C2F746578743E223A303D3D642E6D756C';
wwv_flow_api.g_varchar2_table(37) := '746950657263656E746167653F6B2B3D273C7465787420746578742D616E63686F723D226D6964646C652220783D22272B286E756C6C213D642E74657874583F642E74657874583A2231303022292B272220793D22272B286E756C6C213D642E74657874';
wwv_flow_api.g_varchar2_table(38) := '593F642E74657874593A2231313522292B2722207374796C653D22272B642E746578745374796C652B27222066696C6C3D22272B642E74657874436F6C6F722B27223E272B642E746578742B223C2F746578743E223A313D3D642E6D756C746950657263';
wwv_flow_api.g_varchar2_table(39) := '656E746167652626286B2B3D273C7465787420746578742D616E63686F723D226D6964646C652220783D22272B286E756C6C213D642E74657874583F642E74657874583A2232323822292B272220793D22272B286E756C6C213D642E74657874593F642E';
wwv_flow_api.g_varchar2_table(40) := '74657874593A22363522292B2722207374796C653D22272B642E746578745374796C652B27222066696C6C3D22272B642E74657874436F6C6F722B27223E272B642E746578742B223C2F746578743E22293A642E7465787442656C6F773F6B2B3D273C74';
wwv_flow_api.g_varchar2_table(41) := '65787420746578742D616E63686F723D226D6964646C652220783D22272B286E756C6C213D642E74657874583F642E74657874583A2231303022292B272220793D22272B286E756C6C213D642E74657874593F642E74657874593A2231393022292B2722';
wwv_flow_api.g_varchar2_table(42) := '207374796C653D22272B642E746578745374796C652B27222066696C6C3D22272B642E74657874436F6C6F722B27223E272B642E746578742B223C2F746578743E223A303D3D642E6D756C746950657263656E746167653F6B2B3D273C74657874207465';
wwv_flow_api.g_varchar2_table(43) := '78742D616E63686F723D226D6964646C652220783D22272B286E756C6C213D642E74657874583F642E74657874583A2231303022292B272220793D22272B286E756C6C213D642E74657874593F642E74657874593A2231313522292B2722207374796C65';
wwv_flow_api.g_varchar2_table(44) := '3D22272B642E746578745374796C652B27222066696C6C3D22272B642E74657874436F6C6F722B27223E272B642E746578742B223C2F746578743E223A313D3D642E6D756C746950657263656E746167652626286B2B3D273C7465787420746578742D61';
wwv_flow_api.g_varchar2_table(45) := '6E63686F723D226D6964646C652220783D22272B286E756C6C213D642E74657874583F642E74657874583A2232323822292B272220793D22272B286E756C6C213D642E74657874593F642E74657874593A22363522292B2722207374796C653D22272B64';
wwv_flow_api.g_varchar2_table(46) := '2E746578745374796C652B27222066696C6C3D22272B642E74657874436F6C6F722B27223E272B642E746578742B223C2F746578743E2229292C226E6F6E6522213D642E69636F6E2626286C3D273C7465787420746578742D616E63686F723D226D6964';
wwv_flow_api.g_varchar2_table(47) := '646C652220783D22272B672B272220793D22272B662B272220636C6173733D2269636F6E22207374796C653D22666F6E742D73697A653A20272B642E69636F6E53697A652B277078222066696C6C3D22272B642E69636F6E436F6C6F722B27223E262378';
wwv_flow_api.g_varchar2_table(48) := '272B642E69636F6E2B223C2F746578743E22292C642E68616C66436972636C65297B766172206E3D277472616E73666F726D3D22726F74617465282D3138302C3130302C3130302922273B622E616464436C61737328227376672D636F6E7461696E6572';
wwv_flow_api.g_varchar2_table(49) := '22292E617070656E64286128273C73766720786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F737667222076657273696F6E3D22312E31222076696577426F783D2230203020313934203138362220636C6173733D2263697263';
wwv_flow_api.g_varchar2_table(50) := '6C6966756C223E272B6B2B273C636C6970506174682069643D226375742D6F66662D626F74746F6D223E203C7265637420783D223130302220793D2230222077696474683D2231303022206865696768743D2232303022202F3E203C2F636C6970506174';
wwv_flow_api.g_varchar2_table(51) := '683E3C636972636C652063783D22313030222063793D223130302220723D2235372220636C6173733D22626F72646572222066696C6C3D22272B642E66696C6C436F6C6F722B2722207374726F6B653D22272B642E6261636B67726F756E64436F6C6F72';
wwv_flow_api.g_varchar2_table(52) := '2B2722207374726F6B652D77696474683D22272B6D2B2722207374726F6B652D6461736861727261793D223336302220636C69702D706174683D2275726C28236375742D6F66662D626F74746F6D2922207472616E73666F726D3D22726F74617465282D';
wwv_flow_api.g_varchar2_table(53) := '39302C3130302C3130302922202F3E3C636972636C6520636C6173733D22636972636C65222063783D22313030222063793D223130302220723D2235372220636C6173733D22626F72646572222066696C6C3D226E6F6E6522207374726F6B653D22272B';
wwv_flow_api.g_varchar2_table(54) := '642E666F726567726F756E64436F6C6F722B2722207374726F6B652D77696474683D22272B642E666F726567726F756E64426F7264657257696474682B2722207374726F6B652D6461736861727261793D22302C32303030302220272B6E2B27202F3E3C';
wwv_flow_api.g_varchar2_table(55) := '636972636C652063783D22313030222063793D223130302220723D22272B642E706F696E7453697A652B27222066696C6C3D22272B642E706F696E74436F6C6F722B272220636C69702D706174683D2275726C28236375742D6F66662D626F74746F6D29';
wwv_flow_api.g_varchar2_table(56) := '22207472616E73666F726D3D22726F74617465282D39302C3130302C3130302922202F3E272B6C2B273C7465787420636C6173733D2274696D65722220746578742D616E63686F723D226D6964646C652220783D22272B692B272220793D22272B682B27';
wwv_flow_api.g_varchar2_table(57) := '22207374796C653D22666F6E742D73697A653A20272B642E70657263656E746167655465787453697A652B2270783B20222B6A2B223B222B642E746578744164646974696F6E616C4373732B27222066696C6C3D22272B642E666F6E74436F6C6F722B27';
wwv_flow_api.g_varchar2_table(58) := '223E3C747370616E20636C6173733D226E756D626572223E272B286E756C6C3D3D642E7265706C61636550657263656E746167654279546578743F303A642E7265706C61636550657263656E74616765427954657874292B273C2F747370616E3E3C7473';
wwv_flow_api.g_varchar2_table(59) := '70616E20636C6173733D2270657263656E74223E272B28642E6E6F50657263656E746167655369676E7C7C6E756C6C213D642E7265706C61636550657263656E746167654279546578743F22223A222522292B223C2F747370616E3E3C2F746578743E22';
wwv_flow_api.g_varchar2_table(60) := '29297D656C736520622E616464436C61737328227376672D636F6E7461696E657222292E617070656E64286128273C73766720786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F737667222076657273696F6E3D22312E312220';
wwv_flow_api.g_varchar2_table(61) := '76696577426F783D2230203020313934203138362220636C6173733D22636972636C6966756C223E272B6B2B273C636972636C652063783D22313030222063793D223130302220723D2235372220636C6173733D22626F72646572222066696C6C3D2227';
wwv_flow_api.g_varchar2_table(62) := '2B642E66696C6C436F6C6F722B2722207374726F6B653D22272B642E6261636B67726F756E64436F6C6F722B2722207374726F6B652D77696474683D22272B6D2B2722207374726F6B652D6461736861727261793D2233363022207472616E73666F726D';
wwv_flow_api.g_varchar2_table(63) := '3D22726F74617465282D39302C3130302C3130302922202F3E3C636972636C6520636C6173733D22636972636C65222063783D22313030222063793D223130302220723D2235372220636C6173733D22626F72646572222066696C6C3D226E6F6E652220';
wwv_flow_api.g_varchar2_table(64) := '7374726F6B653D22272B642E666F726567726F756E64436F6C6F722B2722207374726F6B652D77696474683D22272B642E666F726567726F756E64426F7264657257696474682B2722207374726F6B652D6461736861727261793D22302C323030303022';
wwv_flow_api.g_varchar2_table(65) := '207472616E73666F726D3D22726F74617465282D39302C3130302C3130302922202F3E3C636972636C652063783D22313030222063793D223130302220723D22272B642E706F696E7453697A652B27222066696C6C3D22272B642E706F696E74436F6C6F';
wwv_flow_api.g_varchar2_table(66) := '722B2722202F3E272B6C2B273C7465787420636C6173733D2274696D65722220746578742D616E63686F723D226D6964646C652220783D22272B692B272220793D22272B682B2722207374796C653D22666F6E742D73697A653A20272B642E7065726365';
wwv_flow_api.g_varchar2_table(67) := '6E746167655465787453697A652B2270783B20222B6A2B223B222B642E746578744164646974696F6E616C4373732B27222066696C6C3D22272B642E666F6E74436F6C6F722B27223E3C747370616E20636C6173733D226E756D626572223E272B286E75';
wwv_flow_api.g_varchar2_table(68) := '6C6C3D3D642E7265706C61636550657263656E746167654279546578743F303A642E7265706C61636550657263656E74616765427954657874292B273C2F747370616E3E3C747370616E20636C6173733D2270657263656E74223E272B28642E6E6F5065';
wwv_flow_api.g_varchar2_table(69) := '7263656E746167655369676E7C7C6E756C6C213D642E7265706C61636550657263656E746167654279546578743F22223A222522292B223C2F747370616E3E3C2F746578743E2229293B766172206F3D622E66696E6428222E636972636C6522292C703D';
wwv_flow_api.g_varchar2_table(70) := '622E66696E6428222E74696D657222292C713D33302C723D302C733D642E616E696D6174696F6E537465702C743D302C753D302C763D302C773D652C783D332E362A653B642E68616C66436972636C65262628783D332E362A652F32292C6E756C6C213D';
wwv_flow_api.g_varchar2_table(71) := '642E7265706C61636550657263656E74616765427954657874262628773D642E7265706C61636550657263656E74616765427954657874292C642E73746172743E302626642E7461726765743E30262628653D642E73746172742F28642E746172676574';
wwv_flow_api.g_varchar2_table(72) := '2F313030292C763D642E7461726765742F313030292C313D3D642E616E696D6174696F6E3F642E616E696D617465496E566965773F612877696E646F77292E7363726F6C6C2866756E6374696F6E28297B4128297D293A7928293A286F2E617474722822';
wwv_flow_api.g_varchar2_table(73) := '7374726F6B652D646173686172726179222C782B222C20323030303022292C313D3D642E73686F7750657263656E743F702E66696E6428222E6E756D62657222292E746578742877293A28702E66696E6428222E6E756D62657222292E7465787428642E';
wwv_flow_api.g_varchar2_table(74) := '746172676574292C702E66696E6428222E70657263656E7422292E746578742822222929297D297D7D286A5175657279293B0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(8156310960364167)
,p_plugin_id=>wwv_flow_api.id(7951224823997243)
,p_file_name=>'js/jquery.circliful.min.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
