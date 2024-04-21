# Programming

The code is a Java program that simulates a basic e-commerce system.It contains many classes such as :
Product: This is the super class for all products sold in the system. It has properties like productId, name, and price, and methods to get and set these values.
ElectronicProduct: This class inherits from Product and adds specific properties for electronic products like brand and warrantyPeriod.
ClothingProduct: Similar to ElectronicProduct, this class inherits from Product and adds properties for clothing items like size and fabric.
BookProduct: Inherits from Product and has properties specific to books like author and publisher.
Customer: This class stores customer information like customerId, name, and address.
Order: This class represents an order placed by a customer. It has properties like customerId, orderId, products (an array of products in the order), and totalPrice. It also has a method printOrderInfo to display the order details.
Cart: This class represents a customer's shopping cart. It has properties like customerId, nProducts (maximum number of items the cart can hold), element (keeps track of the number of items currently in the cart), and products (an array to store the products in the cart). It has methods to add/remove products, calculate the total price, and place an order (which creates an Order object).

Main Class (EcommerceSystem):
This is the entry point of the program.It creates sample product objects (electronicProduct, clothingProduct, and bookProduct).
It allows the user to enter customer information (customerId, name, and address) and creates a Customer object.
It asks the user how many products they want to add to the cart and creates a Cart object with that size.
It presents the user with a menu to choose products to add to the cart. Based on the user's choice, it adds the corresponding product to the cart using the addProduct method of the Cart class.
After adding products, it calculates the total price using the calculatePrice method of the Cart class and displays it to the user.
Finally, it asks the user if they want to place the order. If yes, it calls the placeOrder method of the Cart class, which creates an Order object with the cart information and prints the order details using the printOrderInfo method.
In this project I focused on multiple concepts such as 
1-Inheritance: The code utilizes inheritance to create a hierarchy of product types. The Product class acts as the base class, defining common properties like productId, name, and price for all products. Specific product types like ElectronicProduct, ClothingProduct, and BookProduct inherit from Product. They add their own unique properties (brand and warrantyPeriod for electronics, size and fabric for clothing, and author and publisher for books) while still maintaining the inherited properties from Product. This promotes code reusability and reduces redundancy.
2-Arrays:Product Array in Cart as the Cart class utilizes an array named products to store the products added to the cart. This array allows the cart to hold multiple products of any type (Product, ElectronicProduct, ClothingProduct, or BookProduct) because they all inherit from the same base Product class.
3-Methods:addProduct method in Cart: This method takes a Product object as input and adds it to the products array in the cart. Inheritance allows this method to work with any product type as long as it inherits from Product.
calculatePrice method in Cart: This method iterates through the products array and accumulates the price of each product using the inherited getPrice method from the Product class. Inheritance ensures consistent price retrieval across all product types.
placeOrder method in Cart: This method creates an Order object. Here's how methods from different classes work together:
It uses the customerId from the Cart class.
It creates a new Order with a unique orderId.
It passes the products array from the Cart class to the Order object.
It calls the calculatePrice method of the Cart class again to get the total price and sets it in the Order object.
printOrderInfo method in Order: This method iterates through the products array (inherited from Cart) and uses the inherited getName and getPrice methods (from Product) to display the product details in the order information.
In a nutshell, the code leverages inheritance to create a product hierarchy with shared functionalities. It then utilizes arrays in the Cart class to manage multiple products and methods throughout the code to perform various actions like adding products, calculating prices, and displaying order information. These methods rely on inheritance to ensure consistent behavior across different product types.
Overall, this is a basic example of an e-commerce system built with Java. It demonstrates concepts like object-oriented programming, inheritance, and working with user input.
