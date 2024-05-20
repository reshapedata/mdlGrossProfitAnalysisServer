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
#' rule_rebateFobamountServer()
rule_rebateFobamountServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token

  text_rule_rebateFobamount_Fbillno= tsui::var_text( 'text_rule_rebateFobamount_Fbillno')
  text_rule_rebateFobamount_FCountStandard= tsui::var_text( 'text_rule_rebateFobamount_FCountStandard')

  text_rule_rebateFobamount_FBillNo_delete= tsui::var_text( 'text_rule_rebateFobamount_FBillNo_delete')



  #查询
  shiny::observeEvent(input$btn_rule_rebateFobamount_view,{
    data=mdlGrossProfitAnalysisPkg::rule_rebateFobamount_view(token=dms_token)
    tsui::run_dataTable2(id = 'rule_rebateFobamount_resultView',data=data)

  })
  #添加
  shiny::observeEvent(input$btn_rule_rebateFobamount_add,{
    FBillNo = text_rule_rebateFobamount_Fbillno()
    FCountStandard = text_rule_rebateFobamount_FCountStandard()
    mdlGrossProfitAnalysisPkg::rule_rebateFobamount_add(token=dms_token, FBillNo = FBillNo,FCountStandard = FCountStandard )
    tsui::pop_notice('添加完成')
  })

  #删除
  shiny::observeEvent(input$btn_rule_rebateFobamount_delete,{



    if (is.null(text_rule_rebateFobamount_FBillNo_delete())){

      tsui::pop_notice('请输入单据编号')
    }
    else{

      FBillNo = text_rule_rebateFobamount_FBillNo_delete()
      mdlGrossProfitAnalysisPkg::rule_rebateFobamount_delete(token=dms_token,FBillNo =FBillNo )
      tsui::pop_notice('删除完成')
    }

  })

}
