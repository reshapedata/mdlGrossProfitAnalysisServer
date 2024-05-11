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
#' rule_fanLiQtyServer()
rule_fanLiQtyServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token

  text_rule_fanLiQty_delete=tsui::var_text('text_rule_fanLiQty_FBillNo_delete')
  text_rule_fanLiQty_FBillNo=tsui::var_text('text_rule_fanLiQty_FBillNo')
  text_rule_fanLiQty_FCustomerName=tsui::var_text('text_rule_fanLiQty_FCustomerName')
  text_rule_fanLiQty_FIndexType=tsui::var_text('text_rule_fanLiQty_FIndexType')
  text_rule_fanLiQty_FStartRealQty=tsui::var_text('text_rule_fanLiQty_FStartRealQty')

  text_rule_fanLiQty_FEndRealQty=tsui::var_text('text_rule_fanLiQty_FEndRealQty')
  text_rule_fanLiQty_FUnit=tsui::var_text('text_rule_fanLiQty_FUnit')

  text_rule_fanLiQty_FRebateProduct=tsui::var_text('text_rule_fanLiQty_FRebateProduct')
  text_rule_fanLiQty_FRebateRate=tsui::var_text('text_rule_fanLiQty_FRebateRate')
  text_rule_fanLiQty_FEffectDate=tsui::var_date('text_rule_fanLiQty_FEffectDate')

  text_rule_fanLiQty_FExpireDate=tsui::var_date('text_rule_fanLiQty_FExpireDate')


  #查询
  shiny::observeEvent(input$btn_rule_fanLiQty_view,{
    data=mdlGrossProfitAnalysisPkg::rule_fanLiQty_view(token=dms_token)
    tsui::run_dataTable2(id = 'rule_fanLiQty_resultView',data=data)

  })
  #添加
  shiny::observeEvent(input$btn_rule_fanLiQty_add,{
    FBillNo = text_rule_fanLiQty_FBillNo()
    FCustomerName = text_rule_fanLiQty_FCustomerName()
    FIndexType =text_rule_fanLiQty_FIndexType()
    FStartRealQty = text_rule_fanLiQty_FStartRealQty()
    FEndRealQty = text_rule_fanLiQty_FEndRealQty()

    FUnit = text_rule_fanLiQty_FUnit()
    FRebateProduct=text_rule_fanLiQty_FRebateProduct()
    FRebateRate = text_rule_fanLiQty_FRebateRate()
    FEffectDate = text_rule_fanLiQty_FEffectDate()
    FExpireDate = text_rule_fanLiQty_FExpireDate()
    mdlGrossProfitAnalysisPkg::rule_fanLiQty_add(token=dms_token,FBillNo =FBillNo ,FCustomerName =FCustomerName ,FIndexType = FIndexType,FStartRealQty = FStartRealQty,FEndRealQty =FEndRealQty ,FUnit = FUnit,FRebateProduct = FRebateProduct,FRebateRate =FRebateRate ,FEffectDate =FEffectDate ,FExpireDate = FExpireDate)
    tsui::pop_notice('添加完成')
    })

  #删除
  shiny::observeEvent(input$btn_rule_fanLiQty_delete,{
    FBillNo = text_rule_fanLiQty_delete()

    mdlGrossProfitAnalysisPkg::rule_fanLiQty_delete(token=dms_token,FBillNo =FBillNo )
    tsui::pop_notice('删除完成')
  })

}
