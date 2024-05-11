
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
#' sal_returnStockServer()
sal_returnStockServer <- function(input,output,session,dms_token,erp_token) {
  #一般按纽,用于计数器显示
  var_text_sal_returnStock_year=tsui::var_text('text_sal_returnStock_year')
  var_text_sal_returnStock_month=tsui::var_text('text_sal_returnStock_month')


  shiny::observeEvent(input$btn_sal_returnStock_select,{

    data=mdlGrossProfitAnalysisPkg::sal_returnStock_select(token = dms_token)
    tsui::run_dataTable2(id ='sal_returnStock_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_sal_returnStock',data = data,filename = '销售退货数据.xlsx')



  })
  shiny::observeEvent(input$btn_sal_returnStock_delete,{

    mdlGrossProfitAnalysisPkg::sal_returnStock_delete(token = dms_token)
    tsui::pop_notice('数据已清除')


  })
  shiny::observeEvent(input$btn_sal_returnStock_up,{
    if(var_text_sal_returnStock_year()==''){

      tsui::pop_notice("请输入年份")

    }
    else if(var_text_sal_returnStock_month()==''){
      tsui::pop_notice("请输入月份")
    }
    else
    {
      mdlGrossProfitAnalysisPkg::returnStock_deleteBydata(dmstoken = dms_token,year = var_text_sal_returnStock_year(),MONTH =var_text_sal_returnStock_month() )

      erpdata = mdlGrossProfitAnalysisPkg::returnscock_jherp_selectBydata(erptoken =erp_token ,year =var_text_sal_returnStock_year() ,MONTH =var_text_sal_returnStock_month() )

      tsda::db_writeTable2(token = dms_token,table_name = 'rds_dms_t_sal_returnStock',r_object = erpdata,append = TRUE)

      tsui::pop_notice('销售退货数据上传完成')

    }


  })

}
