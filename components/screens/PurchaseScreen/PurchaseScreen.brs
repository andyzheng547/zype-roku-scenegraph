function Init()
  m.private = {}

  m.contentHelpers = ContentHelpers()
  m.initializers = initializers()
	m.helpers = helpers()

  m.initializers.initChildren(m)
end function

' ***********
' Callbacks
' 
' Assignment - onVisibleChange(), onPurchaseItemChanged(), onItemNameChanged()
' Actions - onKeyEvent(), onOauthSelected(), onPurchaseButtonSelected()
' ***********
function onKeyEvent(key as string, press as boolean) as boolean
  result = false

  if key = "down"
    m.oauthButton.setFocus(true)
  else if key = "up"
    m.purchaseButtons.setFocus(true)
  else if key = "back"
    result = true
  end if

  return false
end function

function onVisibleChange() as void
  if m.top.visible = true
    m.PurchaseButtons.setFocus(true)
  end if
end function

function onPurchaseItemChanged() as void
  btns = [
    { title: "Purchase video - " + m.top.purchaseItem.cost, role: "confirm_purchase" },
    { title: "Cancel", role: "cancel" }
  ]
  m.purchaseButtons.content = m.contentHelpers.oneDimList2ContentNode(btns, "ButtonNode")
end function

function onItemNameChanged() as void
  m.itemLabel.text = m.top.itemName
end function

function onOauthSelected() as void
  m.top.itemSelectedRole = m.oauthButton.content.getChild(0).role
  m.top.itemSelectedTarget = m.oauthButton.content.getChild(0).target
end function

function onPurchaseButtonSelected() as void
  index = m.purchaseButtons.itemSelected
  m.top.itemSelectedRole = m.purchaseButtons.content.getChild(index).role
  m.top.itemSelectedTarget = m.purchaseButtons.content.getChild(index).target
end function

' *****************************************************
' Component helpers - internal / private functions only
' *****************************************************
function helpers() as object
  this = {}

  return this
end function

' ***************
' Initialization 
' ***************
function initializers() as object
  this = {}

  this.initChildren = function(self) as void
    self.top.observeField("visible", "onVisibleChange")

    self.background = self.top.findNode("Background")
    self.background.color = self.global.theme.background_color

    self.header = self.top.findNode("Header")
    self.header.text = "Confirm purchase"
    self.header.color = self.global.theme.primary_text_color

    self.itemLabel = self.top.findNode("ItemNameLabel")
    self.itemLabel.text = "Product"
    self.itemLabel.color = self.global.theme.primary_text_color

    self.purchaseButtons = self.top.findNode("PurchaseButtons")
    self.purchaseButtons.color = self.global.theme.primary_text_color
    self.purchaseButtons.focusedColor = self.global.theme.background_color
    self.purchaseButtons.focusBitmapUri = self.global.theme.button_filledin_uri
    self.purchaseButtons.focusFootprintBitmapUri = self.global.theme.focus_grid_uri

    btns = [
      { title: "Purchase product - $X.XX", role: "confirm_purchase" },
      { title: "Cancel", role: "cancel" }
    ]
    self.purchaseButtons.content = self.contentHelpers.oneDimList2ContentNode(btns, "ButtonNode")

    self.oauthButton = self.top.findNode("OAuthButton")
    self.oauthButton.color = self.global.theme.primary_text_color
    self.oauthButton.focusedColor = self.global.theme.background_color
    self.oauthButton.focusBitmapUri = self.global.theme.button_filledin_uri
    self.oauthButton.focusFootprintBitmapUri = self.global.theme.focus_grid_uri

    oauthBtn = [{ title: self.global.labels.sign_in_button, role: "transition", target: "UniversalAuthSelection" }]
    self.oauthButton.content = self.contentHelpers.oneDimList2ContentNode(oauthBtn, "ButtonNode")

    self.oauthLabel = self.top.findNode("OAuthLabel")
    self.oauthLabel.color = self.global.theme.primary_text_color
  end function

  this.setupPurchaseButtons = function(self, btnContent) as void
    self.purchaseButtons.content = btnContent
  end function

  return this
end function