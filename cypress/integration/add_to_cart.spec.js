describe("add to cart button", () => {

  it("can increase the count in cart by one after clicking 'Add to Cart' button for a product on the home page", () => {
    cy.visit("/")
    cy.get(".products article").should("be.visible")
    cy.get(".products article").should("have.length", 2)

    cy.get("li.nav-item.end-0").should("contain", 0)
    cy.contains("Add").first().click({force: true})
    cy.get("li.nav-item.end-0").should("contain", 1)

  })
  
})