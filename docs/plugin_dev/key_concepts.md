# Key Concepts

Before writing any code, it helps to have the big picture. You only need to understand **four** things — everything in this guide builds on them.

## 1. A plugin adds actions

A **plugin** is a small Python package you drop into StreamController. On its own it does nothing visible — its job is to provide one or more **actions**.

## 2. An action is what sits on a button

An **action** is the thing a user places onto a button. It does two jobs:

- **Draws** something — an image, an icon, some text.
- **Reacts** to input — for example, when the button is pressed.

Everything you build in this guide is an action (or a few of them).

## 3. Inputs come in three types

StreamController controls more than just buttons. An action can be placed on any of three **input types**:

| Input | What it is |
|---|---|
| **Key** | A normal button on the deck. |
| **Dial** | A rotary knob (e.g. on the Stream Deck +) — it can be turned and pressed. |
| **Touchscreen** | The touch strip on the Stream Deck +. |

You decide which input types your action supports. Most actions start with keys and add dials later.

## 4. Backends are optional

If your action needs heavy Python libraries, StreamController can run them in a separate **backend** process so they never slow down or clash with the app. You won't need this at first — we'll get to it near the end.

---

## How you'll test

You don't need a physical Stream Deck. StreamController can emulate one with a **FakeDeck**:

1. Open **Settings → Developer Settings**
2. Increase the number of **FakeDecks**

A fake deck behaves like a real one, so you can build and test your whole plugin without any hardware.

---

That's the entire mental model: **a plugin registers actions, actions draw and react on inputs, and a backend is there if you need it.** Ready? Let's [build one step by step](getting_started.md).
