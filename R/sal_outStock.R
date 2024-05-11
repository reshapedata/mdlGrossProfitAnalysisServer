
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' sal_outStockServer()
sal_outStockServer <- function(input,output,session,dms_token,erp_token) {
  #一般按纽,用于计数器显示
  var_text_sal_outStock_year=tsui::var_text('text_sal_outStock_year')
  var_text_sal_outStock_month=tsui::var_text('text_sal_outStock_month')


  shiny::observeEvent(input$btn_sal_outStock_select,{

    data=mdlGrossProfitAnalysisPkg::sal_outStock_select(token = dms_token)
    tsui::run_dataTable2(id ='sal_outStock_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_sal_outStock',data = data,filename = '销售出库数据.xlsx')


  })
  shiny::observeEvent(input$btn_sal_outStock_delete,{

    mdlGrossProfitAnalysisPkg::sal_outStock_delete(token = dms_token)
    tsui::pop_notice('数据已清除')


  })
  shiny::observeEvent(input$btn_sal_outStock_up,{
    if(var_text_sal_outStock_year()==''){

      tsui::pop_notice("请输入年份")

    }
    else if(var_text_sal_outStock_month()==''){
      tsui::pop_notice("请输入月份")
    }
    else
    {
      mdlGrossProfitAnalysisPkg::outstock_deleteBydata(dmstoken = dms_token,year = var_text_sal_outStock_year(),MONTH =var_text_sal_outStock_month() )
      #mdlGrossProfitAnalysisPkg::outstock_deleteBydata(dmstoken = dms_token,year = var_text_sal_outStock_year(),MONTH =var_text_sal_outStock_month() )

      erpdata = mdlGrossProfitAnalysisPkg::outstock_jherp_selectBydata(erptoken =erp_token ,year =var_text_sal_outStock_year() ,MONTH =var_text_sal_outStock_month() )

      tsda::db_writeTable2(token = dms_token,table_name = 'rds_dms_t_sal_outStock',r_object = erpdata,append = TRUE)

      tsui::pop_notice('销售出库数据上传完成')

    }


  })

}
