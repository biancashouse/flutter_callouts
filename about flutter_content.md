---
title: "[]{#_srql1m9xlux9 .anchor}Flutter Content Publishing"
---

+-----------------------------------+-----------------------------------+
| Callouts dart API                 | Snippets                          |
|                                   |                                   |
| Callout Configuration UI          | Can compose via a devtools-like   |
|                                   | UI (or in dart)                   |
|                                   |                                   |
|                                   | Snippets stored in Firebase       |
+===================================+===================================+
| Snippet and Page rendering        | Snippet Versioning + Live         |
| widgets                           | Publishing                        |
+-----------------------------------+-----------------------------------+
| Most flutter widgets are          |                                   |
| represented by a Snippet Node     |                                   |
| type                              |                                   |
+-----------------------------------+-----------------------------------+
|                                   |                                   |
+-----------------------------------+-----------------------------------+

The **flutter_callouts** package has a dart API, a large collection of
widgets, and an accompanying ***devtools***-like UI for editing and
publishing content in your flutter apps...

# Introducing **snippets** {#introducing-snippets .unnumbered}

As a flutter developer, you know that:

##### *The element tree is a fundamental concept in Flutter that works alongside the widget tree to render the UI of your application.*  {#the-element-tree-is-a-fundamental-concept-in-flutter-that-works-alongside-the-widget-tree-to-render-the-ui-of-your-application. .unnumbered}

##### *Every widget in your Flutter app has a corresponding element in the element tree.* {#every-widget-in-your-flutter-app-has-a-corresponding-element-in-the-element-tree. .unnumbered}

##### *You build your app's UI by coding in dart.* {#you-build-your-apps-ui-by-coding-in-dart. .unnumbered}

But, if your app includes a lot of editorial content, then creating and
recreating that content in dart is not an efficient use of a developer's
time.

A **snippet tree** refers to a hierarchy of lightweight nodes that can
be used to build all, or parts of your flutter app.

Instead of composing your app from flutter widgets in dart,

#### Q: Why not just use flutter widgets ? {#q-why-not-just-use-flutter-widgets .unnumbered}

#### A: Until now, you have composed your app using flutter widgets in dart code. That works great. But if you build parts of your UI using Snippets, you get some key benefits:  {#a-until-now-you-have-composed-your-app-using-flutter-widgets-in-dart-code.-that-works-great.-but-if-you-build-parts-of-your-ui-using-snippets-you-get-some-key-benefits .unnumbered}

#### Visual design via a *devtools*-like UI. (no coding)

#### Snippets are persisted & versioned in Firestore.

#### Publishing snippet changes in your app is immediate: no need to build and redeploy your app to your web server, or to a \*Store.

##### If much of your app's UI is editorial content, you can delegate such work to content designers who don't have to be coders.

##### There are snippet nodes that also model 3rd party package functionality, such as MultiSplitView, Poll, Stepper, Carousel, Iframe (for including Google Drive content)

A **snippet** is a tree of json objects (nodes), that you build in JSON,
or visually in a tree editor UI. Each node type corresponds to a
built-in flutter widget, or to a 3rd-party pub.dev flutter widget.

You render your snippets in **SnippetPanel**s.
