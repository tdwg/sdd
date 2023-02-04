<html>
            <head>
                <title>DescriptiveConcepts - SDD Primer</title>
                <meta charset="utf-8">
                <style>body { margin: 1em auto; max-width: 1000px; font-size: 16px; font-family: sans-serif; }</style>
            </head>
            <body>
                <p>GregorHagedorn - Tue Aug 28 2007 - Version 1.16<br> <a href="SddContents.html">Parent topic: SddContents</a><br></p>

<h2>SDD Part 0: Introduction and Primer to the SDD Standard </h2>

<h3>3.17 Descriptive concepts.</h3>

<p>Descriptive Concepts in SDD comprise terminological and ontological elements used in descriptions that extend the simple characters and states defined in the &lt;Characters&gt; element. Core descriptive concepts include score modifiers, grouping concepts used in character trees, and "global" (re-useable) states.</p>

<p>Score modifiers are data elements used to modify a standard score (code) in a coded description. For example, flowers in <i>Viola odorata</i> are normally violet but rarely white. In a coded description, the state "white" of the character "Flower colour" can be annotated with the modifer "rarely". The modifer and its meaning are defined in &lt;<a href="DescriptiveConcepts.html">DescriptiveConcepts</a>&gt;.</p>

<p>Grouping concepts are used when characters (defined in &lt;Characters&gt;) are arranged into character trees (in &lt;CharacterTrees&gt;). For example, the characters "Eye colour" and "Eye shape" may be arranged under the grouping concept "Eyes". The concept is defined in &lt;<a href="DescriptiveConcepts.html">DescriptiveConcepts</a>&gt; and referenced in &lt;CharacterTrees&gt;.</p>

<p>Global states are states used in multiple places in a character list. For example, the states "blue" and "white" may be used to describe both scales and fins in descriptions of fish. The states may be defined in &lt;<a href="DescriptiveConcepts.html">DescriptiveConcepts</a>&gt; then referenced for several characters in &lt;Characters&gt;. </p>

<h4>3.17.1 Data modifier definitions.</h4>

<p>In SDD all modifiers for probability (e.g. "possibly"), frequency (e.g. "rarely"), degree (e.g. "strongly"), timing (e.g. "when mature"), location (e.g. "at the base"), etc. are centrally managed using the &lt;Modifers&gt; element.</p>

<p>A simple SDD instance document for data modifiers (as used by Lucid (<a href="http://www.lucidcentral.org">www.lucidcentral.org</a>) has the basic structure shown below and in Example 3.17.1.1.</p>

<p><a href="DescriptiveConcepts/modifier.gif"><img src="DescriptiveConcepts/modifier.gif"/></a></p>

<h5>Example 3.17.1.1 - Describing the Lucid scoring model using the &lt;modifiers&gt; element.</h5>

<table bgcolor="#ddddff" border="0" width="100%" cellpadding="5" cellspacing="5" style="border-collapse: collapse" bordercolor="#111111">
<tr><td>
<pre><code>    &lt;DescriptiveConcepts&gt;
      &lt;DescriptiveConcept id="dc0"&gt;
        &lt;Representation&gt;
          &lt;Label&gt;Fixed set of modifiers supported in Lucid3&lt;/Label&gt;
        &lt;/Representation&gt;
        &lt;Modifiers&gt;
          &lt;Modifier id="mod1"&gt;
            &lt;Representation&gt;
              &lt;Label&gt;rarely&lt;/Label&gt;
            &lt;/Representation&gt;
            &lt;ModifierClass&gt;Frequency&lt;/ModifierClass&gt;
            &lt;ProportionRange lowerestimate="0.0" upperestimate="0.25"/&gt;
          &lt;/Modifier&gt;
          &lt;Modifier id="mod2"&gt;
            &lt;Representation&gt;
              &lt;Label&gt;uncertain&lt;/Label&gt;
            &lt;/Representation&gt;
            &lt;ModifierClass&gt;Certainty&lt;/ModifierClass&gt;
            &lt;ProportionRange lowerestimate="0.0" upperestimate="0.5"/&gt;
          &lt;/Modifier&gt;
          &lt;Modifier id="mod3"&gt;
            &lt;Representation&gt;
              &lt;Label&gt;misinterpreted&lt;/Label&gt;
            &lt;/Representation&gt;
            &lt;ModifierClass&gt;TreatAsMisinterpretation&lt;/ModifierClass&gt;
          &lt;/Modifier&gt;
          &lt;Modifier id="mod4"&gt;
            &lt;Representation&gt;
              &lt;Label&gt;unscoped&lt;/Label&gt;
            &lt;/Representation&gt;
            &lt;ModifierClass&gt;OtherModifierClass&lt;/ModifierClass&gt;
          &lt;/Modifier&gt;
        &lt;/Modifiers&gt;
      &lt;/DescriptiveConcept&gt;
    &lt;/DescriptiveConcepts&gt;
</code></pre>
</td></tr></table>

<p>The &lt;Representation&gt; element provides a label for a set of modifiers. This may be useful if the instance document includes multiple sets of modifiers for different purposes (e.g., "frequency modifiers", "certainty modifiers", "location modifiers", "color modifiers", "seasonal modifiers").</p>

<p>&lt;ModifierClass&gt; may optionally be used where interoperable specifications are desired. There are currently 6 modifier classes available:</p>

<ul>
  <li>1. Frequency (&lt;ProportionRange&gt; defines the frequency limits (between 0 and 1) for the modifier).</li>
  <li>2. Certainty (&lt;ProportionRange&gt; defines the certainty limits (between 0 and 1) for the modifier. A range of 0 to 0 implies zero certainty = certainly false)</li>
  <li>3. Seasonal (&lt;ProportionRange&gt; defines the range of dates for the modifier.)</li>
  <li>4. Diurnal (&lt;ProportionRange&gt; defines the range of times for the modifier, using a 24 hour day).</li>
  <li>5. !TreatAsMisinterpretation. With this set, the current modifier becomes one of a special class of misinterpretation modifiers. States to which such modifiers are added are known to be intentionally wrongly scored to accomodate known misunderstandings of the character under study. For example, bracts of a dogwood (<i>Cornus</i>)look like petals; this taxon may be scored as Petals: present (by misinterpretation) to accommodate likely misinterpretation of this feature by a user.</li>
  <li>6. !OtherModifierClass (used for extensibility)</li>
</ul>

<p>Modifiers may be assigned language specific labels and assigned usage for generation of natural language descriptions. Using a very simple grammar, the concatenation of these phrases yields a simple natural language description. See the example below.</p>

<h5>Example 3.17.1.2 - Language specific labels and modifiers.</h5>

<table bgcolor="#ddddff" border="0" width="100%" cellpadding="5" cellspacing="5" style="border-collapse: collapse" bordercolor="#111111">
<tr><td>

<pre><code>&lt;DescriptiveConcept id="dc40"&gt;
  &lt;Representation&gt;
    &lt;Label&gt;Preferred certainty modifiers&lt;/Label&gt;
  &lt;/Representation&gt;
  &lt;Modifiers&gt;
    &lt;Modifier id="mc40"&gt;
      &lt;Representation&gt;
        &lt;Label xml:lang="en"&gt;probably&lt;/Label&gt;
        &lt;Label xml:lang="de"&gt;vermutlich&lt;/Label&gt;
      &lt;/Representation&gt;
      &lt;NaturalLanguage&gt;
        &lt;Phrase xml:lang="en" role="Before"&gt;probably &lt;/Phrase&gt;
        &lt;Phrase xml:lang="de" role="Before"&gt;vermutlich &lt;/Phrase&gt;
      &lt;/NaturalLanguage&gt;
      &lt;ModifierClass&gt;Certainty&lt;/ModifierClass&gt;
      &lt;ProportionRange lowerestimate="0.6" upperestimate="1"/&gt;
    &lt;/Modifier&gt;
    &lt;Modifier id="mc41"&gt;
      &lt;Representation&gt;
        &lt;Label xml:lang="en"&gt;perhaps&lt;/Label&gt;
        &lt;Label xml:lang="de"&gt;eventuell&lt;/Label&gt;
      &lt;/Representation&gt;
      &lt;NaturalLanguage&gt;
        &lt;Phrase xml:lang="en" role="Before"&gt;perhaps &lt;/Phrase&gt;
        &lt;Phrase xml:lang="de" role="Before"&gt;eventuell &lt;/Phrase&gt;
      &lt;/NaturalLanguage&gt;
      &lt;ModifierClass&gt;Certainty&lt;/ModifierClass&gt;
      &lt;ProportionRange lowerestimate="0" upperestimate="0.5"/&gt;
    &lt;/Modifier&gt;
    &lt;Modifier id="mc42"&gt;
      &lt;Representation&gt;
        &lt;Label xml:lang="en"&gt;(by misinterpretation)&lt;/Label&gt;
        &lt;Label xml:lang="de"&gt;(durch Fehlinterpretation)&lt;/Label&gt;
      &lt;/Representation&gt;
      &lt;NaturalLanguage&gt;
        &lt;Phrase xml:lang="en" role="After"&gt;(by misinterpretation)&lt;/Phrase&gt;
        &lt;Phrase xml:lang="de" role="After"&gt;(Fehlinterpretation)&lt;/Phrase&gt;
      &lt;/NaturalLanguage&gt;
      &lt;ModifierClass&gt;TreatAsMisinterpretation&lt;/ModifierClass&gt;
      &lt;ProportionRange lowerestimate="0" upperestimate="0"/&gt;
    &lt;/Modifier&gt;
  &lt;/Modifiers&gt;
&lt;/DescriptiveConcept&gt;
</code></pre>

</td></tr></table>

<h4>3.17.2 Grouping concepts</h4>

<p>Character hierarchies comprise a tree of nodes with characters at the end of each branch, as demonstrated in the example below.</p>

<p><a href="DescriptiveConcepts/character_trees_example.gif"><img src="DescriptiveConcepts/character_trees_example.gif"/></a></p>

<p>Internal nodes in a character tree are not characters but grouping concepts. These are defined in the &lt;<a href="DescriptiveConcepts.html">DescriptiveConcepts</a>&gt; element and referenced within the &lt;CharacterTree&gt; element, as in the example below.</p>

<table bgcolor="#ddddff" border="0" width="100%" cellpadding="5" cellspacing="5" style="border-collapse: collapse" bordercolor="#111111">
<tr>
<td>
<pre><code>      &lt;DescriptiveConcepts&gt;
      &lt;DescriptiveConcept id="dc1"&gt;
        &lt;Representation&gt;
          &lt;Label&gt;Flowers&lt;/Label&gt;
        &lt;/Representation&gt;
      &lt;/DescriptiveConcept&gt;
      &lt;DescriptiveConcept id="dc2"&gt;
        &lt;Representation&gt;
          &lt;Label&gt;Petals&lt;/Label&gt;
        &lt;/Representation&gt;
      &lt;/DescriptiveConcept&gt;
                 ...etc
      &lt;/DescriptiveConcepts&gt;
</code></pre>
</td>
</tr>
</table>

<p>For more information on using groupinf concepts to build a character tree, see the topic <a href="CharacterHierarchies.html">Character Hierarchies</a></p>

<h4>3.17.3 Sharing states across characters (Concept States)</h4>

<p>SDD provides a mechanism for defining state values that are reusable in multiple characters. For example the concept state 'blue' may be applied to many different colour descriptors such as "Eye colour', 'Fin colour' and 'Tail colour'. Similarly, the state "ovate" may be used for "Leaf shape", "Petal shape", "Seed shape" etc.  Using concept states simplifies the management of terminology and improves data analysis, as states from different characters can be compared if they refer to identical concept states.</p>

<p>Concept states are defined in much the same way as local states (i.e. states defined within a character). Once defined, concept states are referenced in the definition of a character. The basic structure od SDD code for concept states has the basic structure shown below and in example 3.5.1.2.</p>

<p><a href="DescriptiveConcepts/conceptstates.gif"><img src="DescriptiveConcepts/conceptstates.gif"/></a></p>

<h5>Example 3.17.3.1 - SDD representation of the categorical characters in 3.5.1.1.</h5>

<table bgcolor="#ddddff" border="0" width="100%" cellpadding="5" cellspacing="5" style="border-collapse: collapse" bordercolor="#111111">
<tr>
<td>
<pre><code> &lt;DescriptiveConcept id="dc40"&gt;
   &lt;Representation&gt;
     &lt;Label&gt;Preferred certainty modifiers&lt;/Label&gt;
   &lt;/Representation&gt;
   &lt;ConceptStates&gt;
     &lt;StateDefinition id="cs1"&gt;
       &lt;Representation&gt;
         &lt;Label&gt;blue&lt;/Label&gt;
       &lt;/Representation&gt;
      &lt;/StateDefinition&gt;
     &lt;StateDefinition id="cs2"&gt;
       &lt;Representation&gt;
         &lt;Label&gt;white&lt;/Label&gt;
       &lt;/Representation&gt;
      &lt;/StateDefinition&gt;
      ...etc.
    &lt;/ConceptStates&gt;
 &lt;/DescriptiveConcept&gt;
 ...
 &lt;Characters&gt;
   &lt;CategoricalCharacter id="c1"&gt;
     &lt;Representation&gt;
       &lt;Label&gt;Eye Colour&lt;/Label&gt;
     &lt;/Representation&gt;
     &lt;States&gt;
       &lt;StateReference ref="cs1"/&gt;
       &lt;StateReference ref="cs2"/&gt;
     &lt;/States&gt;
    &lt;/CategoricalCharacter&gt;
    ...etc.
   &lt;/Characters&gt;
</code></pre>
</td>
</tr>
</table>

<p>In this example, the states "blue" and "white" are defined as &lt;ConceptStates&gt; within a descriptive concept. When the categorical character "Eye Colour" is defined in &lt;Characters&gt;, the concepts states are referenced (using their ids cs1 and cs2), instead of local states being defined.</p>


            </body>
            </html>