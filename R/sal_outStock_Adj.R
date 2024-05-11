

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
#' sal_outStock_AdjServer()
sal_outStock_AdjServer <- function(input,output,session,dms_token) {
  var_file_btn_sal_outStock_Adj = tsui::var_file('btn_sal_outStock_Adj')

  shiny::observeEvent(input$btn_sal_outStock_AdjUp,{
    if(is.null(var_file_btn_sal_outStock_Adj())){

      tsui::pop_notice('请先上传文件')
    }
    else{
      filename=var_file_btn_sal_outStock_Adj()
      data <- readxl::read_excel(filename,
                                 col_types = c("date", "text", "text",
                                               "text", "text", "text", "text", "numeric",
                                               "text", "text", "text", "text", "text",
                                               "text", "text", "numeric", "numeric",
                                               "numeric", "numeric", "numeric",
                                               "numeric", "numeric", "numeric",
                                               "text", "text"))
      data = as.data.frame(data)

      data = tsdo::na_standard(data)
      tsda::db_writeTable2(token = dms_token,table_name = 'rds_dms_t_sal_outStock_Adj',r_object = data,append = TRUE)
      tsui::pop_notice('上传成功')



    }

  })

  shiny::observeEvent(input$btn_sal_outStock_Adj,{



      data=mdlGrossProfitAnalysisPkg::sal_outStock_Adj_select(token =dms_token )


      tsui::run_dataTable2(id ='sal_outStock_Adj_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_sal_outStock_Adj',data = data,filename = '手工调整单数据.xlsx')



  })
  shiny::observeEvent(input$btn_sal_outStock_Adj_delete,{
    mdlGrossProfitAnalysisPkg::sal_outStock_Adj_delete(token = dms_token)
    tsui::pop_notice('调整单数据已清空')

  })




  }




