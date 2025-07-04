// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello!...`
  String get hello {
    return Intl.message('Hello!...', name: 'hello', desc: '', args: []);
  }

  /// `Sign In`
  String get signin {
    return Intl.message('Sign In', name: 'signin', desc: '', args: []);
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `User Name`
  String get name {
    return Intl.message('User Name', name: 'name', desc: '', args: []);
  }

  /// `Enter Your User Name`
  String get enter_name {
    return Intl.message(
      'Enter Your User Name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Enter Your Email`
  String get enter_email {
    return Intl.message(
      'Enter Your Email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Enter Your Phone`
  String get enter_phone {
    return Intl.message(
      'Enter Your Phone',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Your Password`
  String get your_password {
    return Intl.message(
      'Your Password',
      name: 'your_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get enter_your_password {
    return Intl.message(
      'Enter Your Password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message('Enter', name: 'enter', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirm Your Password`
  String get enter_confirm_your_password {
    return Intl.message(
      'Enter Confirm Your Password',
      name: 'enter_confirm_your_password',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'current' key

  /// `New `
  String get new_ {
    return Intl.message('New ', name: 'new_', desc: '', args: []);
  }

  /// `Confirm New `
  String get confirm_new {
    return Intl.message(
      'Confirm New ',
      name: 'confirm_new',
      desc: '',
      args: [],
    );
  }

  /// `By signing up, you agree to `
  String get terms_and_condition1 {
    return Intl.message(
      'By signing up, you agree to ',
      name: 'terms_and_condition1',
      desc: '',
      args: [],
    );
  }

  /// `our Terms of Service and Privacy Policy.`
  String get terms_and_condition2 {
    return Intl.message(
      'our Terms of Service and Privacy Policy.',
      name: 'terms_and_condition2',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forget_password {
    return Intl.message(
      'Forget Password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get do_not_have_an_account {
    return Intl.message(
      'Don’t have an account?',
      name: 'do_not_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get sign_with_google {
    return Intl.message(
      'Sign in with Google',
      name: 'sign_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get sign_with_facebook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'sign_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!...`
  String get welcome_back {
    return Intl.message(
      'Welcome back!...',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `   OR SIGN IN WITH   `
  String get or {
    return Intl.message(
      '   OR SIGN IN WITH   ',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `or continue with`
  String get or_continue_with {
    return Intl.message(
      'or continue with',
      name: 'or_continue_with',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Login to continue`
  String get login_to_continue {
    return Intl.message(
      'Login to continue',
      name: 'login_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Create Account to continue`
  String get create_account_to_continue {
    return Intl.message(
      'Create Account to continue',
      name: 'create_account_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Create Account to continue and enjoy our services`
  String get create_account_to_continue_description {
    return Intl.message(
      'Create Account to continue and enjoy our services',
      name: 'create_account_to_continue_description',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Shopping Cart`
  String get shopping_cart {
    return Intl.message(
      'Shopping Cart',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Orders`
  String get gg {
    return Intl.message('Orders', name: 'gg', desc: '', args: []);
  }

  /// `Change Theme`
  String get change_theme {
    return Intl.message(
      'Change Theme',
      name: 'change_theme',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get change_email {
    return Intl.message(
      'Change Email',
      name: 'change_email',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Please Enter Your New Email Address`
  String get edit_email_message {
    return Intl.message(
      'Please Enter Your New Email Address',
      name: 'edit_email_message',
      desc: '',
      args: [],
    );
  }

  /// `Please Verify Your Email To Activate Your Account`
  String get please_verify_your_email {
    return Intl.message(
      'Please Verify Your Email To Activate Your Account',
      name: 'please_verify_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message('Light Mode', name: 'light_mode', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `See All`
  String get see_all {
    return Intl.message('See All', name: 'see_all', desc: '', args: []);
  }

  /// `Best Selling`
  String get best_selling {
    return Intl.message(
      'Best Selling',
      name: 'best_selling',
      desc: '',
      args: [],
    );
  }

  /// `LE`
  String get le {
    return Intl.message('LE', name: 'le', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Search For Products`
  String get search_for_products {
    return Intl.message(
      'Search For Products',
      name: 'search_for_products',
      desc: '',
      args: [],
    );
  }

  /// `Shop Now`
  String get shop_now {
    return Intl.message('Shop Now', name: 'shop_now', desc: '', args: []);
  }

  /// `Check Your Email`
  String get check_your_email {
    return Intl.message(
      'Check Your Email',
      name: 'check_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email Addresss To Recieve A Verification Code`
  String get please_enter_your_email {
    return Intl.message(
      'Please Enter Your Email Addresss To Recieve A Verification Code',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get verification_code {
    return Intl.message(
      'Verification Code',
      name: 'verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Check Code`
  String get check_code {
    return Intl.message('Check Code', name: 'check_code', desc: '', args: []);
  }

  /// `Please Enter Your Digit Code Sent To  `
  String get please_enter_your_verification_code {
    return Intl.message(
      'Please Enter Your Digit Code Sent To  ',
      name: 'please_enter_your_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verify_code {
    return Intl.message('Verify Code', name: 'verify_code', desc: '', args: []);
  }

  /// `Didn’t Receive Code?`
  String get didnot_receive_code {
    return Intl.message(
      'Didn’t Receive Code?',
      name: 'didnot_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resend_code {
    return Intl.message('Resend Code', name: 'resend_code', desc: '', args: []);
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get create_new_password {
    return Intl.message(
      'Create New Password',
      name: 'create_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Your new password must be different from previous used passwords.`
  String get your_new_password {
    return Intl.message(
      'Your new password must be different from previous used passwords.',
      name: 'your_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Your Password Has Been Changed Successfully`
  String get your_password_has_been_changed {
    return Intl.message(
      'Your Password Has Been Changed Successfully',
      name: 'your_password_has_been_changed',
      desc: '',
      args: [],
    );
  }

  /// `Go To Sign In`
  String get go_to_login {
    return Intl.message(
      'Go To Sign In',
      name: 'go_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Not Valid Email`
  String get not_valid_email {
    return Intl.message(
      'Not Valid Email',
      name: 'not_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Not Valid Phone`
  String get not_valid_phone {
    return Intl.message(
      'Not Valid Phone',
      name: 'not_valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Not Valid Name`
  String get not_valid_name {
    return Intl.message(
      'Not Valid Name',
      name: 'not_valid_name',
      desc: '',
      args: [],
    );
  }

  /// `Cant Be Empty`
  String get cant_be_empty {
    return Intl.message(
      'Cant Be Empty',
      name: 'cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Not Valid Price`
  String get not_valid_price {
    return Intl.message(
      'Not Valid Price',
      name: 'not_valid_price',
      desc: '',
      args: [],
    );
  }

  /// `Cant Be Large Than`
  String get cant_be_large_than {
    return Intl.message(
      'Cant Be Large Than',
      name: 'cant_be_large_than',
      desc: '',
      args: [],
    );
  }

  /// `Cant Be Less Than`
  String get cant_be_less_than {
    return Intl.message(
      'Cant Be Less Than',
      name: 'cant_be_less_than',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Add Categery`
  String get add_category {
    return Intl.message(
      'Add Categery',
      name: 'add_category',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get category {
    return Intl.message('Categories', name: 'category', desc: '', args: []);
  }

  /// `Add Product`
  String get add_product {
    return Intl.message('Add Product', name: 'add_product', desc: '', args: []);
  }

  /// `Product Name Arabic`
  String get product_name_ar {
    return Intl.message(
      'Product Name Arabic',
      name: 'product_name_ar',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Name Arabic`
  String get enter_product_name_ar {
    return Intl.message(
      'Enter Product Name Arabic',
      name: 'enter_product_name_ar',
      desc: '',
      args: [],
    );
  }

  /// `Product Name English`
  String get product_name_en {
    return Intl.message(
      'Product Name English',
      name: 'product_name_en',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Name English`
  String get enter_product_name_en {
    return Intl.message(
      'Enter Product Name English',
      name: 'enter_product_name_en',
      desc: '',
      args: [],
    );
  }

  /// `Product Description Arabic`
  String get product_description_ar {
    return Intl.message(
      'Product Description Arabic',
      name: 'product_description_ar',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Description Arabic`
  String get enter_product_description_ar {
    return Intl.message(
      'Enter Product Description Arabic',
      name: 'enter_product_description_ar',
      desc: '',
      args: [],
    );
  }

  /// `Product Description English`
  String get product_description_en {
    return Intl.message(
      'Product Description English',
      name: 'product_description_en',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Description English`
  String get enter_product_description_en {
    return Intl.message(
      'Enter Product Description English',
      name: 'enter_product_description_en',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get product_price {
    return Intl.message(
      'Product Price',
      name: 'product_price',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Price`
  String get enter_product_price {
    return Intl.message(
      'Enter Product Price',
      name: 'enter_product_price',
      desc: '',
      args: [],
    );
  }

  /// `Product Code`
  String get product_code {
    return Intl.message(
      'Product Code',
      name: 'product_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Code`
  String get enter_product_code {
    return Intl.message(
      'Enter Product Code',
      name: 'enter_product_code',
      desc: '',
      args: [],
    );
  }

  /// `Product Category Arabic`
  String get product_category_ar {
    return Intl.message(
      'Product Category Arabic',
      name: 'product_category_ar',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Category Arabic`
  String get enter_product_category_ar {
    return Intl.message(
      'Enter Product Category Arabic',
      name: 'enter_product_category_ar',
      desc: '',
      args: [],
    );
  }

  /// `Product Category English`
  String get product_category_en {
    return Intl.message(
      'Product Category English',
      name: 'product_category_en',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Category English`
  String get enter_product_category_en {
    return Intl.message(
      'Enter Product Category English',
      name: 'enter_product_category_en',
      desc: '',
      args: [],
    );
  }

  /// `Product Image`
  String get product_image {
    return Intl.message(
      'Product Image',
      name: 'product_image',
      desc: '',
      args: [],
    );
  }

  /// `Is Featured Item`
  String get is_featured_item {
    return Intl.message(
      'Is Featured Item',
      name: 'is_featured_item',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Delete Category`
  String get delete_category {
    return Intl.message(
      'Delete Category',
      name: 'delete_category',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get delete_product {
    return Intl.message(
      'Delete Product',
      name: 'delete_product',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Edit Category`
  String get edit_category {
    return Intl.message(
      'Edit Category',
      name: 'edit_category',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get edit_product {
    return Intl.message(
      'Edit Product',
      name: 'edit_product',
      desc: '',
      args: [],
    );
  }

  /// `No Products Found`
  String get no_products_found {
    return Intl.message(
      'No Products Found',
      name: 'no_products_found',
      desc: '',
      args: [],
    );
  }

  /// `No Categories Found`
  String get no_categories_found {
    return Intl.message(
      'No Categories Found',
      name: 'no_categories_found',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Please Select An Image`
  String get please_select_image {
    return Intl.message(
      'Please Select An Image',
      name: 'please_select_image',
      desc: '',
      args: [],
    );
  }

  /// `Are You Sure You Want To Delete This Product?`
  String get confirm_delete_message_product {
    return Intl.message(
      'Are You Sure You Want To Delete This Product?',
      name: 'confirm_delete_message_product',
      desc: '',
      args: [],
    );
  }

  /// `Are You Sure You Want To Delete This Category?`
  String get confirm_delete_message_category {
    return Intl.message(
      'Are You Sure You Want To Delete This Category?',
      name: 'confirm_delete_message_category',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirm_delete_title {
    return Intl.message(
      'Confirm Delete',
      name: 'confirm_delete_title',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get no_data {
    return Intl.message('No Data', name: 'no_data', desc: '', args: []);
  }

  /// `This Category Already Exists`
  String get categoryExists {
    return Intl.message(
      'This Category Already Exists',
      name: 'categoryExists',
      desc: '',
      args: [],
    );
  }

  /// `Product Edited Successfully`
  String get product_edited_successfully {
    return Intl.message(
      'Product Edited Successfully',
      name: 'product_edited_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Product Added Successfully`
  String get product_added_successfully {
    return Intl.message(
      'Product Added Successfully',
      name: 'product_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Category Edited Successfully`
  String get category_edited_successfully {
    return Intl.message(
      'Category Edited Successfully',
      name: 'category_edited_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Category Added Successfully`
  String get category_added_successfully {
    return Intl.message(
      'Category Added Successfully',
      name: 'category_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Category Deleted Successfully`
  String get category_deleted_successfully {
    return Intl.message(
      'Category Deleted Successfully',
      name: 'category_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Product Deleted Successfully`
  String get product_deleted_successfully {
    return Intl.message(
      'Product Deleted Successfully',
      name: 'product_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Active Categories`
  String get active_categories {
    return Intl.message(
      'Active Categories',
      name: 'active_categories',
      desc: '',
      args: [],
    );
  }

  /// `Inactive Categories`
  String get inactive_categories {
    return Intl.message(
      'Inactive Categories',
      name: 'inactive_categories',
      desc: '',
      args: [],
    );
  }

  /// `Search categories...`
  String get search_categories {
    return Intl.message(
      'Search categories...',
      name: 'search_categories',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get all_categories {
    return Intl.message(
      'All Categories',
      name: 'all_categories',
      desc: '',
      args: [],
    );
  }

  /// `No search results`
  String get empty_search_results {
    return Intl.message(
      'No search results',
      name: 'empty_search_results',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Ok`
  String get ok {
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
  }

  /// `Pull down to refresh`
  String get pull_to_refresh {
    return Intl.message(
      'Pull down to refresh',
      name: 'pull_to_refresh',
      desc: '',
      args: [],
    );
  }

  /// `All Products`
  String get all_products {
    return Intl.message(
      'All Products',
      name: 'all_products',
      desc: '',
      args: [],
    );
  }

  /// `Active Products`
  String get active_products {
    return Intl.message(
      'Active Products',
      name: 'active_products',
      desc: '',
      args: [],
    );
  }

  /// `Inactive Products`
  String get inactive_products {
    return Intl.message(
      'Inactive Products',
      name: 'inactive_products',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profile_updated_successfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profile_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Image updated successfully`
  String get image_updated_successfully {
    return Intl.message(
      'Image updated successfully',
      name: 'image_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid username`
  String get invalid_username {
    return Intl.message(
      'Please enter a valid username',
      name: 'invalid_username',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get invalid_email {
    return Intl.message(
      'Please enter a valid email address',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get invalid_phone {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'invalid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Save`
  String get confirm_save {
    return Intl.message(
      'Confirm Save',
      name: 'confirm_save',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to save these changes?`
  String get save_changes_message {
    return Intl.message(
      'Are you sure you want to save these changes?',
      name: 'save_changes_message',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive {
    return Intl.message('Inactive', name: 'inactive', desc: '', args: []);
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Products`
  String get product {
    return Intl.message('Products', name: 'product', desc: '', args: []);
  }

  /// `Profile edited successfully`
  String get profile_edited_successfully {
    return Intl.message(
      'Profile edited successfully',
      name: 'profile_edited_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get current_password {
    return Intl.message(
      'Current Password',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Current Password`
  String get enter_current_password {
    return Intl.message(
      'Enter Current Password',
      name: 'enter_current_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enter_new_password {
    return Intl.message(
      'Enter New Password',
      name: 'enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirm New Password`
  String get enter_confirm_new_password {
    return Intl.message(
      'Enter Confirm New Password',
      name: 'enter_confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Password updated failed`
  String get password_updated_failed {
    return Intl.message(
      'Password updated failed',
      name: 'password_updated_failed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid current password`
  String get invalid_current_password {
    return Intl.message(
      'Invalid current password',
      name: 'invalid_current_password',
      desc: '',
      args: [],
    );
  }

  /// `New password and confirm password does not match`
  String get new_password_and_confirm_password_does_not_match {
    return Intl.message(
      'New password and confirm password does not match',
      name: 'new_password_and_confirm_password_does_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully`
  String get password_updated_successfully {
    return Intl.message(
      'Password updated successfully',
      name: 'password_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logout_message {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_message',
      desc: '',
      args: [],
    );
  }

  /// `Password and Confirm Password do not match`
  String get password_and_confirm_password_not_match {
    return Intl.message(
      'Password and Confirm Password do not match',
      name: 'password_and_confirm_password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Add Employee`
  String get add_employee {
    return Intl.message(
      'Add Employee',
      name: 'add_employee',
      desc: '',
      args: [],
    );
  }

  /// `Employee added successfully`
  String get success_added_employee {
    return Intl.message(
      'Employee added successfully',
      name: 'success_added_employee',
      desc: '',
      args: [],
    );
  }

  /// `Employee Name`
  String get employee_name {
    return Intl.message(
      'Employee Name',
      name: 'employee_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee Name`
  String get enter_employee_name {
    return Intl.message(
      'Enter Employee Name',
      name: 'enter_employee_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee Type`
  String get enter_employee_type {
    return Intl.message(
      'Enter Employee Type',
      name: 'enter_employee_type',
      desc: '',
      args: [],
    );
  }

  /// `Employee Type`
  String get employee_type {
    return Intl.message(
      'Employee Type',
      name: 'employee_type',
      desc: '',
      args: [],
    );
  }

  /// `Enter Join Date`
  String get enter_join_date {
    return Intl.message(
      'Enter Join Date',
      name: 'enter_join_date',
      desc: '',
      args: [],
    );
  }

  /// `Join Date`
  String get join_date {
    return Intl.message('Join Date', name: 'join_date', desc: '', args: []);
  }

  /// `Enter Direct Manager`
  String get enter_direct_manager {
    return Intl.message(
      'Enter Direct Manager',
      name: 'enter_direct_manager',
      desc: '',
      args: [],
    );
  }

  /// `Direct Manager`
  String get direct_manager {
    return Intl.message(
      'Direct Manager',
      name: 'direct_manager',
      desc: '',
      args: [],
    );
  }

  /// `Enter Area Manager`
  String get enter_area_manager {
    return Intl.message(
      'Enter Area Manager',
      name: 'enter_area_manager',
      desc: '',
      args: [],
    );
  }

  /// `Area Manager`
  String get area_manager {
    return Intl.message(
      'Area Manager',
      name: 'area_manager',
      desc: '',
      args: [],
    );
  }

  /// `Enter Territory`
  String get enter_territory {
    return Intl.message(
      'Enter Territory',
      name: 'enter_territory',
      desc: '',
      args: [],
    );
  }

  /// `Territory`
  String get territory {
    return Intl.message('Territory', name: 'territory', desc: '', args: []);
  }

  /// `Enter Employee Status`
  String get enter_employee_status {
    return Intl.message(
      'Enter Employee Status',
      name: 'enter_employee_status',
      desc: '',
      args: [],
    );
  }

  /// `Employee Status`
  String get employee_status {
    return Intl.message(
      'Employee Status',
      name: 'employee_status',
      desc: '',
      args: [],
    );
  }

  /// `Employee Email`
  String get employee_email {
    return Intl.message(
      'Employee Email',
      name: 'employee_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee Email`
  String get enter_employee_email {
    return Intl.message(
      'Enter Employee Email',
      name: 'enter_employee_email',
      desc: '',
      args: [],
    );
  }

  /// `Employee Phone`
  String get employee_phone {
    return Intl.message(
      'Employee Phone',
      name: 'employee_phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee Phone`
  String get enter_employee_phone {
    return Intl.message(
      'Enter Employee Phone',
      name: 'enter_employee_phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee National ID`
  String get enter_employee_national_id {
    return Intl.message(
      'Enter Employee National ID',
      name: 'enter_employee_national_id',
      desc: '',
      args: [],
    );
  }

  /// `Employee National ID`
  String get employee_national_id {
    return Intl.message(
      'Employee National ID',
      name: 'employee_national_id',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee Address`
  String get employee_enter_address {
    return Intl.message(
      'Enter Employee Address',
      name: 'employee_enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Employee Address`
  String get employee_address {
    return Intl.message(
      'Employee Address',
      name: 'employee_address',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee Basic Salary`
  String get enter_employee_basic_salary {
    return Intl.message(
      'Enter Employee Basic Salary',
      name: 'enter_employee_basic_salary',
      desc: '',
      args: [],
    );
  }

  /// `Employee Basic Salary`
  String get employee_basic_salary {
    return Intl.message(
      'Employee Basic Salary',
      name: 'employee_basic_salary',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee Notes`
  String get enter_employee_notes {
    return Intl.message(
      'Enter Employee Notes',
      name: 'enter_employee_notes',
      desc: '',
      args: [],
    );
  }

  /// `Employee Notes`
  String get employee_notes {
    return Intl.message(
      'Employee Notes',
      name: 'employee_notes',
      desc: '',
      args: [],
    );
  }

  /// `Employee Password`
  String get employee_password {
    return Intl.message(
      'Employee Password',
      name: 'employee_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employee Password`
  String get enter_employee_password {
    return Intl.message(
      'Enter Employee Password',
      name: 'enter_employee_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Employee Password`
  String get confirm_employee_password {
    return Intl.message(
      'Confirm Employee Password',
      name: 'confirm_employee_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirm Employee Password`
  String get enter_confirm_employee_password {
    return Intl.message(
      'Enter Confirm Employee Password',
      name: 'enter_confirm_employee_password',
      desc: '',
      args: [],
    );
  }

  /// `Employee updated successfully`
  String get success_updated_employee {
    return Intl.message(
      'Employee updated successfully',
      name: 'success_updated_employee',
      desc: '',
      args: [],
    );
  }

  /// `Employee deleted successfully`
  String get success_deleted_employee {
    return Intl.message(
      'Employee deleted successfully',
      name: 'success_deleted_employee',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basic_info {
    return Intl.message(
      'Basic Information',
      name: 'basic_info',
      desc: '',
      args: [],
    );
  }

  /// `Contact Information`
  String get contact_info {
    return Intl.message(
      'Contact Information',
      name: 'contact_info',
      desc: '',
      args: [],
    );
  }

  /// `Management Information`
  String get management_info {
    return Intl.message(
      'Management Information',
      name: 'management_info',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Select Employee Type`
  String get select_employee_type {
    return Intl.message(
      'Select Employee Type',
      name: 'select_employee_type',
      desc: '',
      args: [],
    );
  }

  /// `Medical Representative`
  String get medical_representative {
    return Intl.message(
      'Medical Representative',
      name: 'medical_representative',
      desc: '',
      args: [],
    );
  }

  /// `Administrator`
  String get administator {
    return Intl.message(
      'Administrator',
      name: 'administator',
      desc: '',
      args: [],
    );
  }

  /// `Select Employee Status`
  String get select_employee_status {
    return Intl.message(
      'Select Employee Status',
      name: 'select_employee_status',
      desc: '',
      args: [],
    );
  }

  /// `Select Direct Manager`
  String get select_direct_manager {
    return Intl.message(
      'Select Direct Manager',
      name: 'select_direct_manager',
      desc: '',
      args: [],
    );
  }

  /// `Select Area Manager`
  String get select_area_manager {
    return Intl.message(
      'Select Area Manager',
      name: 'select_area_manager',
      desc: '',
      args: [],
    );
  }

  /// `Select Territory`
  String get select_territory {
    return Intl.message(
      'Select Territory',
      name: 'select_territory',
      desc: '',
      args: [],
    );
  }

  /// `Is Admin`
  String get is_admin {
    return Intl.message('Is Admin', name: 'is_admin', desc: '', args: []);
  }

  /// `Enter Is Admin`
  String get enter_is_admin {
    return Intl.message(
      'Enter Is Admin',
      name: 'enter_is_admin',
      desc: '',
      args: [],
    );
  }

  /// `Select Is Admin`
  String get select_is_admin {
    return Intl.message(
      'Select Is Admin',
      name: 'select_is_admin',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
